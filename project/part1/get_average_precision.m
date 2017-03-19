function [AP] = get_average_precision(labels, scores)
    combined = cat(2, scores, labels);
    combined = sortrows(combined);
    combined = flipud(combined);
% combined
    f_c = zeros(size(labels,1), 1);
    counter = 0;
    for i=1:size(labels)
        counter = counter + combined(i,2);
        f_c(i)  = counter;
        if combined(i,2) == 0
            f_c(i) = 0;
        end
        
    end
    
    i = 1:size(labels);
    i=i';
%     f_c
% max(f_c)
    AP = sum(f_c./i)/max(f_c);
end