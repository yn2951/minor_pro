module DeviseHelper
  def devise_error_messages!
    return "" if resource.errors.empty?

    html = ""
    messages = resource.errors.full_messages.each do |errmsg|
      html += <<-EOF
      <div class="error alert-danger alert-dismissible col-md-6 col-md-offset-3 text-center" role="alert">
        <button type="button" class="close" data-dismiss="alert">
        </button>
        #{errmsg}
      </div>
      EOF
    end
    html.html_safe
  end

  def devise_error_messages?
    resource.errors.empty? ? false : true
  end

end
