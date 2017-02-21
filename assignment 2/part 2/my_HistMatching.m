function imOut = my_HistMatching(input , reference )
    %Get histValues for each channel
    [i_frequencies, xi] = imhist(input);
    [r_frequencies, xr] = imhist(reference);
    
    %Plot them together in one plot
    subplot(3, 2, 1);
    plot(xi, i_frequencies); %input histogram
    title('input')
    subplot(3, 2, 2);
    imshow(input);
    
    subplot(3, 2, 3);
    plot(xr, r_frequencies); %reference histogram
    title('reference')
    subplot(3, 2, 4);
    imshow(reference);
    
    subplot(3, 2, 5);
    modified = histeq(reference, i_frequencies);
    [m_frequencies, xm] = imhist(modified);
    plot(xm, m_frequencies);
    title('modified')
    subplot(3, 2, 6);
    imshow(modified)
end

function equalized = hist_eq(input, reference)
    %get reference histogram
    [hgram, ~] = imhist(reference);
    m = length(hgram);
    n=m;
    
    %normalize hgram
    hgram = hgram*(numel(input)/sum(hgram));
    
    %compute cummulative distribution of input
    nn = imhist(input,numel(hgram))';
    cummulative = cumsum(nn);
    
        
    cumd = cumsum(hgram);

    % Create transformation to an intensity image by minimizing the error
    % between desired and actual cumulative histogram.
    tol = ones(m,1)*min([nn(1:n-1),0;0,nn(2:n)])/2;
    err = (cumd(:)*ones(1,n)-ones(m,1)*cummulative(:)')+tol;
    d = find(err < -numel(input)*sqrt(eps));
    if ~isempty(d)
       err(d) = numel(input)*ones(size(d));
    end
    [dum,T] = min(err); %#ok
    T = (T-1)/(m-1);
    equalized = grayxformmex(input, T);



M = zeros(256,1,'uint8'); % Store mapping - Cast to uint8 to respect data type
img1 = input;
img2 = reference;
    
hist1 = imhist(img1);        % Compute histograms
hist2 = imhist(img2);
cdf1 = cumsum(hist1) / numel(img1);  %Compute CDFs
cdf2 = cumsum(hist2) / numel(img2);

% Compute the mapping
for idx = 1 : 256
    [~,ind] = min(abs(cdf1(idx) - cdf2));
    M(idx) = ind-1;
end

%Now apply the mapping to get first image to make
%the image look like the distribution of the second image
equalized = M(double(img1)+1);

end