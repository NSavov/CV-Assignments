function [] = generate_results_html(feature_method, sift_type, ap, mAP, paths, vocabulary_size, sift_block_size, sift_step_size, svm_train_set_size, svm_kernel)
    html_template_path = 'D:\Work\CV 1\CV-Assignments\project\Template_Result.html';
    html_template_file = fullfile(html_template_path);
    html_content = fileread(html_template_file);

    globals;
    
    sample_size = sift_step_size;
%     vocabulary_size =vocabulary_size;
%     sift_block_size =sift_block_size;
    training_data_positive = svm_train_set_size;
    training_data_negative = 3*training_data_positive;
    kernel = svm_kernel;
    stu1_name = 'Nedko Savov';
    stu2_name = 'Fabian Guevara';

    html_content = strrep(html_content, 'sift_step_size', string(sample_size));
    html_content = strrep(html_content, 'sift_block_size', string(sift_block_size));
    html_content = strrep(html_content, 'sift_method', string(sift_type));
    html_content = strrep(html_content, 'vocabulary_size', string(vocabulary_size));
    html_content = strrep(html_content, 'vocabulary_fraction', string(vocabulary_fraction));
    html_content = strrep(html_content, 'training_data_positive', string(training_data_positive));
    html_content = strrep(html_content, 'training_data_negative', string(training_data_negative));
    html_content = strrep(html_content, 'map_result', string(mAP));
    html_content = strrep(html_content, 'kernel_type', kernel);
    html_content = strrep(html_content, 'stu1_name', stu1_name);
    html_content = strrep(html_content, 'stu2_name', stu2_name);

    html_content = strrep(html_content, 'airplanes_ap', string(ap(1)));
    html_content = strrep(html_content, 'cars_ap', string(ap(2)));
    html_content = strrep(html_content, 'faces_ap', string(ap(3)));
    html_content = strrep(html_content, 'motorbikes_ap', string(ap(4)));

    html_body = '';

    row_size = size(paths{1},1);

    for row = 1:row_size
        html_body = strcat(html_body, '<tr>');

        cat_paths = paths{1};
        html_body = strcat(html_body, '<td>');
        html_body = strcat(html_body, '<img src="');
        html_body = strcat(html_body, char(cat_paths(row)));
        html_body = strcat(html_body, '" />');
        html_body = strcat(html_body, '</td>');

            cat_paths = paths{2};
        html_body = strcat(html_body, '<td>');
        html_body = strcat(html_body, '<img src="');
        html_body = strcat(html_body, char(cat_paths(row)));
        html_body = strcat(html_body, '" />');
        html_body = strcat(html_body, '</td>');

            cat_paths = paths{3};
        html_body = strcat(html_body, '<td>');
        html_body = strcat(html_body, '<img src="');
        html_body = strcat(html_body, char(cat_paths(row)));
        html_body = strcat(html_body, '" />');
        html_body = strcat(html_body, '</td>');

            cat_paths = paths{4};
        html_body = strcat(html_body, '<td>');
        html_body = strcat(html_body, '<img src="');
        html_body = strcat(html_body, char(cat_paths(row)));
        html_body = strcat(html_body, '" />');
        html_body = strcat(html_body, '</td>');

        html_body = strcat(html_body, '</tr>');
    end
    html_body = strrep(html_body, '\', '\\');
    html_content = strrep(html_content, 'body_images', html_body);

    fid=fopen(strcat('results_', feature_method, '-', sift_type, '.html'),'w');
    fprintf(fid, html_content);
    fclose(fid);
end