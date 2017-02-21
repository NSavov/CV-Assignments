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
    modified = hist_eq(input, reference);
    [m_frequencies, xm] = imhist(modified);
    plot(xm, m_frequencies);
    title('modified')
    subplot(3, 2, 6);
    imshow(modified)
end

function equalized = hist_eq(input, reference)
    map = zeros(256,1,'uint8');
    hist1 = imhist(input);       
    hist2 = imhist(reference);
    
    %compute cumulative distributions
    c_inp = cumsum(hist1) / numel(input);
    c_ref = cumsum(hist2) / numel(reference);
    
    %compute the mapping function
    for idx = 1 : 256
        [~,ind] = min(abs(c_inp(idx) - c_ref));
        
        %map to the corresponding to the index intensity
        map(idx) = ind-1;
    end

    equalized = uint8(map(double(input)+1));
end