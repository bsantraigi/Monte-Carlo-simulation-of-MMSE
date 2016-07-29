
clc
clear all
close all
p = zeros(3, 1);
q = zeros(3, 1);
r = zeros(3, 1);
A = 3;
for j = 1:5
    N = 10;
    sg_n = sqrt(j);
    samp = 10000;

    arr_mse = zeros(samp, 1);
    arr_smean = zeros(samp, 1);

    mse = @(u, v) mean((u - v).^2);
    for i = 1:samp
        mu_a = 1;
        sg_a = sqrt(0.5);
        
        A = normrnd(mu_a, sg_a);
        x = normrnd(A, sg_n, N, 1);
        
        M = sum(x)/sg_n^2 + mu_a/sg_a^2;
        C = N/sg_n^2 + 1/sg_a^2;

        A_e = M/C;
        arr_mse(i) = mse(A, A_e);
        arr_smean(i) = mse(A, mean(x));
    end

    disp(['Var: ' num2str(j)])
    mse_exp = mean(arr_mse)
    mse_smean = mean(arr_smean)

    % Theoretical
    mse_t = 1/(C)
    p(j) = mse_t;
    q(j) = mse_exp;
    r(j) = mse_smean;
end
%%
figure(1)
clf
hold on
plot(p, 'o')
plot(q)
plot(r)
legend('Theoretical', 'Post. Mean', 'Sample Mean');
hold off