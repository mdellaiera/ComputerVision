#include <stdio.h>
#include <math.h>
#include "mex.h"
#include "matrix.h"


#define M_PI 3.141592653589793

/*
	Subf = Ubf(S_vec, sigs, sigl, a, im_gray, r, nb_iteration);
*/


void copyDescriptor(double* S_out, double* S_in, unsigned long total_len) {
	unsigned long i;
	for (i = 0; i < total_len; i++)
		S_out[i] = S_in[i];
}


void spacePonderation(double *S, int r, double sigs) {
	int iq, jq, k;
	double sv = 0.0, v;
	double *pS = S;

	for (jq = - r; jq <= r; jq++)
		for (iq = - r; iq <= r; iq++) {
			v = exp(-(double)(iq*iq + jq*jq) / (2.0*sigs*sigs));
			sv += v;
			*(pS++) = v;
		}

	for (k = 0; k < (2 * r + 1)*(2 * r + 1); k++)
		//S[k] /= sqrt(2 * M_PI) * sigs;
		S[k] /= sv;
}


void luminancePonderation(double *L, double* im, int r, double sigl, int rows, int cols) {
	int ip, jp, iq, jq, ij_p, ij_q;
	double lumPond, dLum, im_ij_p;
	double *pL = L;

	for (jp = r; jp < cols - r; jp++)
		for (ip = r; ip < rows - r; ip++) {
			ij_p = ip + jp * rows;
			im_ij_p = im[ij_p];
			for (jq = -r; jq <= r; jq++)
				for (iq = -r; iq <= r; iq++) {
					ij_q = iq + jq * rows;
					dLum = (im_ij_p - im[ij_p + ij_q]) / sigl;
					lumPond = exp(-dLum * dLum / 2.0);
					*(pL++) = lumPond;
				}
		}
}


void Ubf(double* S_out, double* S_in, double* S, double* L, int r, double a, int svec, int rows, int cols) {
	int ip, jp, iq, jq, k, ij_p, ij_q;
	double lumPond, spacePond, dLum, w, im_ij_p;
	double *pS_out, *pS_in_p, *pS_in_pq, *pL, *pS;

	pL = L;
	for (jp = r; jp < cols - r; jp++)
		for (ip = r; ip < rows - r; ip++) {
			pS = S;
			ij_p = ip + jp * rows;
			for (jq = -r; jq <= r; jq++)
				for (iq = -r; iq <= r; iq++) {
					ij_q = iq + jq * rows;
					spacePond = *(pS++);
					lumPond = *(pL++);
					w = a * lumPond * spacePond;
					pS_out = S_out + ij_p * svec;
					pS_in_p = S_in + ij_p * svec;
					pS_in_pq = S_in + (ij_p + ij_q) * svec;
					for (k = 0; k < svec; k++)
						*(pS_out++) += (*(pS_in_pq++) - *(pS_in_p++)) * w;
				}
		}
}


void mexFunction(int nlhs, mxArray *plhs[], int nrhs, const mxArray *prhs[]) {

	// Variable declaration
	mwSize ndim, *dims;
	int nb_it;
	double a, sigs, sigl;
	double *S_in, *im;


	// Check if inputs and ouputs are correct
	if (nrhs != 6)
		mexErrMsgTxt("The number of input argument must be six : S_vec, im_gray, sigs, sigl, a, nb_iteration");

	if (nlhs > 1)
		mexErrMsgTxt("The number of output argument must be one (Subf) or zero (ans).");

	if (mxGetNumberOfDimensions(prhs[0]) != 3)
		mexErrMsgTxt("First argument (S) must have three dimensions.");

	if (mxGetNumberOfDimensions(prhs[1]) != 2)
		mexErrMsgTxt("Second argument (im_gray) must have two dimensions.");

	if (!mxIsDouble(prhs[0]))
		mexErrMsgTxt("First argument (S) must be double.");

	if (!mxIsDouble(prhs[1]))
		mexErrMsgTxt("Second argument (S) must be double.");

	if (mxGetNumberOfElements(prhs[2]) != 1)
		mexErrMsgTxt("Third argument (sigs) must be a singleton.");

	if (mxGetNumberOfElements(prhs[3]) != 1)
		mexErrMsgTxt("Forth argument (sigl) must be a singleton.");

	if (mxGetNumberOfElements(prhs[4]) != 1)
		mexErrMsgTxt("Fifth argument (a) must be a singleton.");

	if (mxGetNumberOfElements(prhs[5]) != 1)
		mexErrMsgTxt("Last argument (nb_iteration) must be a singleton.");


	// Read input data
	ndim  = mxGetNumberOfDimensions(prhs[0]);
	dims  = mxGetDimensions(prhs[0]);
	S_in  = mxGetPr(prhs[0]);
	im    = mxGetPr(prhs[1]);
	sigs  = mxGetScalar(prhs[2]);
	sigl  = mxGetScalar(prhs[3]);
	a     = mxGetScalar(prhs[4]);
	nb_it = (int)mxGetScalar(prhs[5]);

	int svec = dims[0]; // vector size
	int rows = dims[1];
	int cols = dims[2];


	// Unnormalized bilateral filtering
	unsigned long total_len = svec * rows * cols;
	int r = 3 * (int)sigs;
	int n;

	double* S = (double *)calloc((2 * r + 1)*(2 * r + 1), sizeof(double));
	double* L = (double *)calloc((2 * r + 1)*(2 * r + 1) * rows * cols, sizeof(double));
	double* S_aux = (double *)calloc(total_len, sizeof(double));
	double* S_out = (double *)calloc(total_len, sizeof(double));

	spacePonderation(S, r, sigs);
	luminancePonderation(L, im, r, sigl, rows, cols);
	copyDescriptor(S_aux, S_in, total_len);
	copyDescriptor(S_out, S_in, total_len);

	for (n = 0; n < nb_it; n++) {
		Ubf(S_out, S_aux, S, L, r, a, svec, rows, cols);
		copyDescriptor(S_aux, S_out, total_len);
	}


	// Prepare the output
	unsigned long p;
	plhs[0] = mxCreateNumericArray(ndim, dims, mxDOUBLE_CLASS, mxREAL);
	double* data = mxGetPr(plhs[0]);
	for (p = 0; p < total_len; p++)
		data[p] = S_out[p];


	// Free memory
	free(S_out);
	free(S_aux);
	free(S);
	free(L);

	return;
}