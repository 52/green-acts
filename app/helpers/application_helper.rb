module ApplicationHelper
  def full_title title = ""
    title.empty? ? "Green Acts" : "#{title} | Green Acts"
  end
end
