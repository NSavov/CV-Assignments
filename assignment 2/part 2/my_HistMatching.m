function imOut = my_HistMatching(input , reference )
    %Get histValues for each channel
    [i_frequencies, xi] = imhist(input);
    [r_frequencies, xr] = imhist(reference);
    %Plot them together in one plot
    subplot(3, 2, 1);
    plot(xi, i_frequencies); %input histogram
    subplot(3, 2, 2);
    imshow(input);
    subplot(3, 2, 3);
    plot(xr, r_frequencies); %reference histogram
    subplot(3, 2, 4);
    imshow(reference);
    modified = histeq(reference, i_frequencies);
    [m_frequencies, xm] = imhist(modified);
    subplot(3, 2, 5);
    plot(xm, m_frequencies);
    subplot(3, 2, 6);
    imshow(modified)
end