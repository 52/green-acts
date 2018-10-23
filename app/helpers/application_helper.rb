module ApplicationHelper
  def full_title title = ""
    title.empty? ? "Green Acts" : "#{title} | Green Acts"
  end

  def bootstrap_alert_class_for alert_type
    alert_type_mapping = {
      notice: "alert-info",
      alert:  "alert-warning",
      error:  "alert-danger"
    }

    alert_type_mapping.fetch alert_type.to_sym, "alert-#{alert_type}"
  end
end
