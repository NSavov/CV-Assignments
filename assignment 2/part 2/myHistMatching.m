function imOut = myHistMatching(input , reference )
    %Get histValues for each channel
    [i_frequencies, xi] = imhist(input);
    [r_frequencies, xr] = imhist(reference);
    
    %Plot them together in one plot
    subplot(3, 2, 1);
    bar(xi, i_frequencies); %input histogram
    title('input')
    subplot(3, 2, 2);
    imshow(input);
    
    subplot(3, 2, 3);
    bar(xr, r_frequencies); %reference histogram
    title('reference')
    subplot(3, 2, 4);
    imshow(reference);
    
    subplot(3, 2, 5);
    modified = hist_eq(input, reference);
    imOut = modified;
    [m_frequencies, xm] = imhist(modified);
    bar(xm, m_frequencies);
    title('modified')
    subplot(3, 2, 6);
    imshow(modified)
end

function equalized = hist_eq(input, reference)
% HIST_EQ given input and reference greyscale images, it produces an equalized
% version of the input image approximating the intensity distribution of
% the reference image
%   input: input image as a matrix of greyscale uint8 values
%   reference: reference image whose intensity distribution is to be
%   approximated 
%   equalized: a new image based on input but approximating the intensity
%   distribution of reference
    % vector to map input to reference intensities. map(i) = j means that
    % intensity i in input image corresponds to intensity j in the
    % equalized image. Therefore map has 256 entries, to cover every
    % possible intensity
    map = zeros(256,1,'uint8'); 
    % intensity distribution of input image. I.e. hist1(i) is the count of
    % pixels in input image with intensity i
    hist1 = imhist(input); 
    hist2 = imhist(reference);
    
    %compute cumulative distributions. cumsum([1 2 3]) = [1 3 6]. You
    %divide that by the number of pixel (numel(input)) and you get
    %cumulative frequencies
    c_inp = cumsum(hist1) / numel(input);
    c_ref = cumsum(hist2) / numel(reference);

    %compute the mapping function
    for idx = 1 : 256
        %for each frequency of input image, find the frequency in reference
        %image with the closest cummulative value
        [~,ind] = min(abs(c_inp(idx) - c_ref));
        
        %now map(output_freq) = frequency from reference image that best
        %approximates output_freq. Subtracting 1 is important since
        %intensities go from 0 to 255, whereas matlab arrays start at 1
        map(idx) = ind-1;
    end
    %and then, the final image is equal to the input, but for each pixel,
    %we replace its intensity in the input image by the intensity given by
    %map
    equalized = uint8(map(double(input)+1));
end