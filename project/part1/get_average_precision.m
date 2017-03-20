function [AP, ranking] = get_average_precision(labels, scores)
    path_indices = 1:size(labels);
    ranking = cat(2, scores, labels, path_indices');
    ranking = sortrows(ranking,1);
    ranking = flipud(ranking);
    f_c = zeros(size(labels,1), 1);
    counter = 0;
    for i=1:size(labels)
        counter = counter + ranking(i,2);
        f_c(i)  = counter;
        if ranking(i,2) == 0
            f_c(i) = 0;
        end
        
    end
    
    i = 1:size(labels);
    i=i';
    AP = sum(f_c./i)/max(f_c);
    
    
end