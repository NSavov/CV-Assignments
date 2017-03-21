function create_html(settings, results)
    [step_size, block_size, sift_method, sift_setting, training_example_count, vocab_size, vocab_fraction, svm_training_data_positive, svm_training_data_negative, kernel] = deal(settings{:});
    [fns_c1, fns_c2, fns_c3, fns_c4, ap, map] = deal(results{:});
    html_template = 'template_result.html';
    fstr = fileread(html_template);
    
    fstr = strrep(fstr, 'stu1_name', 'Nedko Savov (11404345)');
    fstr = strrep(fstr, 'stu2_name', 'Fabián Guevara (11390786)');
    
    % settings    
    if strcmp(step_size, '-1')
       step_size = 'default';
    end
    
    if strcmp(block_size, '-1') 
       block_size = 'default'; 
    end
    
    fstr = strrep(fstr, '_siftstepsizeXXX', step_size);
    fstr = strrep(fstr, '_siftblocksizesXXX', block_size);
    fstr = strrep(fstr, '_siftmethodXXX-SIFT', sift_method);
    fstr = strrep(fstr, '_vocabularysizeXXX', int2str(vocab_size));
    fstr = strrep(fstr, '_vocabularyfractionXXX', num2str(vocab_fraction, 3));
    fstr = strrep(fstr, '_svm_trainingXXXpositive', svm_training_data_positive);
    fstr = strrep(fstr, '_svm_trainingXXXnegative', svm_training_data_negative);
    fstr = strrep(fstr, '_svmkerneltypeXXX', kernel);
    fstr = strrep(fstr, '_map0.XXX', num2str(map, 3));
    fstr = strrep(fstr, '_airplanes0.XXX', num2str(ap(1), 3));
    fstr = strrep(fstr, '_cars0.XXX', num2str(ap(2), 3));
    fstr = strrep(fstr, '_faces0.XXX', num2str(ap(3), 3));
    fstr = strrep(fstr, '_motorbikes0.XXX', num2str(ap(4), 3));
    
    
    images_per_category = size(fns_c1,2);
    for i = 1:images_per_category
        fstr = cat(2, fstr, '<tr><td><img src="', fns_c1{i}, '" /></td>');
        fstr = cat(2, fstr, '<td><img src="', fns_c2{i}, '" /></td>');
        fstr = cat(2, fstr, '<td><img src="', fns_c3{i}, '" /></td>');
        fstr = cat(2, fstr, '<td><img src="', fns_c4{i}, '" /></td></tr>');
    end
    fstr = cat(2, fstr, '</tbody>\n</table>\n</body>\n</html>');
    save_fn = char(strcat(sift_method, '_', sift_setting, '_', int2str(training_example_count), '_', int2str(vocab_size), '_', kernel, '_', num2str(round(map*100)), '.html'));
    fid = fopen(save_fn, 'wt');
    fprintf(fid, fstr);
    fclose(fid);
end
