function LD = calc_distance(mu1,mu2,sigma1,sigma2)
    sigma1_sqrt=matrixsqrt(sigma1);
    mix_sigma = sigma1_sqrt*sigma2*sigma1_sqrt;
    mix_sigma_sqrt=matrixsqrt(mix_sigma);
    LD=sum((mu1-mu2).^2) + max(trace(sigma1+sigma2-2*mix_sigma_sqrt),0);
%     LD=sum((mu1-mu2).^2) + trace(sigma1+sigma2-2*mix_sigma_sqrt);
end