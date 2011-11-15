class UserFilesController < ApplicationController
  def show
    user_file = UserFile.find(params[:id])
    #todo security check here
    send_file user_file.data.path, :type => user_file.data_content_type
  end

    #this will be called via ajax/remote
  def destroy
    user_file = UserFile.find(params[:id])
    @user_file_id = user_file.id.to_s
    @allowed = Job::Max_Attachments - user_file.attachable.user_files.count
    user_file.destroy
  end
end
