function [meanEmoVec, A, Eigenfaces] = EigenfaceCore(T)
% Use Principle Component Analysis (PCA) to determine the most 
% discriminating features between images of faces.
%
% Description: This function gets a 2D matrix, containing all training image vectors
% and returns 3 outputs which are extracted from training database.
%
% Argument:      T                      - A 2D matrix, containing all 1D image vectors.
%                                         Suppose all P images in the training database 
%                                         have the same size of MxN. So the length of 1D 
%                                         column vectors is M*N and 'T' will be a MNxP 2D matrix.
% 
% Returns:       meanEmoVec                      - (M*Nx1) Mean of the training database
%                Eigenfaces             - (M*Nx(P-1)) Eigen vectors of the covariance matrix of the training database
%                A                      - (M*NxP) Matrix of centered image vectors
%
% See also: EIG

% Original version by Amir Hossein Omidvarnia, October 2007
%                     Email: aomidvar@ece.ut.ac.ir                  
 
%%%%%%%%%%%%%%%%%%%%%%%% Calculating the mean image 
meanEmoVec = mean(T, 2); % Computing the average emotion vector m = (1/P)*sum(Tj's)    (j = 1 : P)
numOfSamples = size(T, 2);
sampleLen = size(T, 1);

%%%%%%%%%%%%%%%%%%%%%%%% Calculating the deviation of each image from mean image
A = zeros(sampleLen, numOfSamples);  
for (sampleInd = 1 : numOfSamples)
    tempFlattenImg = double(T(:, sampleInd)) - meanEmoVec; % Computing the difference vector for each vector in the training set Ai = Ti - m
    A(:, sampleInd) = tempFlattenImg; % Merging all centered images
end

%%%%%%%%%%%%%%%%%%%%%%%% Snapshot method of Eigenface methos
% We know from linear algebra theory that for a PxQ matrix, the maximum
% number of non-zero eigenvalues that the matrix can have is min(P-1,Q-1).
% Since the number of training images (P) is usually less than the number
% of pixels (M*N), the most non-zero eigenvalues that can be found are equal
% to P-1. So we can calculate eigenvalues of A'*A (a PxP matrix) instead of
% A*A' (a M*NxM*N matrix). It is clear that the dimensions of A*A' is much
% larger that A'*A. So the dimensionality will decrease.

%b=A';
L = A'*A; % L is the surrogate of covariance matrix C=A*A'.
%save ('L.mat', 'L')
%load 'L.mat'

[V D] = eig(L); % Diagonal elements of D are the eigenvalues for both L=A'*A and C=A*A'.
diagonal = diag (D);

%zero = zeros(1,(size(A,2)-size(A,1))); % A*A'
diagonal = flipud (diagonal);
%diagonal = [diagonal; zero'];           % A*A'
%plot(diagonal);


% ------------------------
% Debug only
global allEigenVals;
allEigenVals = diag(D);
eigValsMask = zeros(size(D, 1), 1);
% ------------------------


%%%%%%%%%%%%%%%%%%%%%%%% Sorting and eliminating eigenvalues
% All eigenvalues of matrix L are sorted and those who are less than a
% specified threshold, are eliminated. So the number of non-zero
% eigenvectors may be less than (P-1).

L_eig_vec = [];
xMax = max(allEigenVals);
xMmin = min(allEigenVals);

N = size(V,1);

for i = 1 : N
    if( diagonal(i)>0.3)
        L_eig_vec = [L_eig_vec V(:,N+1-i)];
        
        eigValsMask(i) = 1;
    end
end



% 
% L_eig_vec = [];
% xMax = max(allEigenVals);
% xMmin = min(allEigenVals);
% 
% for i = 1 : size(V,2)
%     if( D(i,i)>1 )
%         L_eig_vec = [L_eig_vec V(:,i)]
%         eig
%         eigValsMask(i) = 1;
%     end
% end
% L_eig_vec


% ------------------------
% Debug only
global refinedEigenVals;
refinedEigenVals = allEigenVals.*eigValsMask;
% ------------------------

%%%%%%%%%%%%%%%%%%%%%%%% Calculating the eigenvectors of covariance matrix 'C'
% Eigenvectors of covariance matrix C (or so-called "Eigenfaces")
% can be recovered from L's eiegnvectors.
Eigenfaces = A * L_eig_vec; % A: centered image vectors
%Eigenfaces =  L_eig_vec;
% To test
% nn=10;
% errLst = zeros(1, nn);
% for (ii=1:nn)
%     errLst(ii) = norm(L * L_eig_vec(:, ii) - refinedEigenVals(ii)*L_eig_vec(:, ii));
% end



end