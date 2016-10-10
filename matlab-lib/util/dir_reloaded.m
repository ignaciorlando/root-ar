
function filenames = dir_reloaded(folder)

    % retrieve all filenames in folder
    filenames = dir(folder);
    % get only the names of the images inside the folder
    filenames = {filenames.name};
    % and now remove garbage from the operating system
    filenames(strcmp(filenames, '..')) = [];
    filenames(strcmp(filenames, '.')) = [];
    filenames(strcmp(filenames, 'Thumbs.db')) = [];
end