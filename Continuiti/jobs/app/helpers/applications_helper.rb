module ApplicationsHelper

  def application_count(job_id, application_status)
    Application.application_count(job_id, application_status)
  end

end
