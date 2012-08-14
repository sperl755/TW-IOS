# Methods added to this helper will be available to all templates in the application.

module ApplicationHelper
  #include "D:/work/sperling_project/C_engine/vendor/plugins/community_engine/app/helpers/base_helper.rb"
  def show_flash_message_xhr(page)
    page.replace_html :flash_messages_and_notice, :partial => "/shared/messages"
    flash[:notice] = nil
  end

  def display_date_with_ago_words(display_date)  #date can be date or datetime
    return nil if display_date.blank?
    ago = distance_of_time_in_words(display_date, Time.now, true)
    if ago.blank?
      str=display_date.strftime('%d %b, %Y')
    else
      str=display_date.strftime('%d %b, %Y')+" ("+ago+" before)"
    end
    return str
  end

end
