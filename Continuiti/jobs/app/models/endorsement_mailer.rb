class EndorsementMailer < ActionMailer::Base
  def invite_user_to_endorse_me(message_subject, message, email, user_requesting_endorse)
    recipients email
    from       "Awesome Jobsite <jobsite@example.com>"
    subject    message_subject
    sent_on    Time.now
    body       :message => message, :user => user_requesting_endorse, :url => "http://hydrogen.xen.exoware.net:3000#{new_endorsement_path(:user_requesting_endorse_id => user_requesting_endorse.id)}"
    content_type "text/html"
  end

  def share_the_badge_to_friend(email, sender, badge)
    recipients email
    from       "Awesome Jobsite <jobsite@example.com>"
    subject    "You've got a badge"
    sent_on    Time.now
    body       :sender => sender, :badge => badge
    content_type "text/html"
  end
end
