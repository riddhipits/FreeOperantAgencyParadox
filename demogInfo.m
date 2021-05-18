% RJP 9/05/2021

function [subject] = demogInfo(settings)

    % the questions asked
    prompt = {'Subject ID:','Gender (m/f):','Age:','Experiment restarted? (1 = yes; 0 = no): '}; 
    
    % structure of the answers: dialogue box
    answer = inputdlg(prompt); 

    % information obtained from participants
    subject.id = str2double(answer{1});
    subject.gender = str2double(answer{2});
    subject.age = str2double(answer{3});
    subject.restart = str2double(answer{4});
    subject.date = date;
    subject.start_time = clock;
    subject.name = answer{1};  
    subject.screen = 0;
    
    % specifying directory to save the demographic information
    settings.rawdata_path = 'rawdata/'; 
    subject.dir = subject.name; % ensures that each participant gets their own folder
   
    % creating directory if it does not already exist
    if ~exist([settings.rawdata_path subject.dir '/behaviour'], 'dir') 
        mkdir([settings.rawdata_path subject.dir '/behaviour']);
    end
    
    % specifying the unique filename using computer clock to avoid overwriting old files
    subject.fileName = [num2str(round(datenum(subject.start_time)*100000)) '_' num2str(subject.id)];
end