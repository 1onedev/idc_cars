module ApplicationHelper
  def number_to_usd(number)
    number_to_currency(number, precision: 0, format: '%u%n', unit: '$')
  end

  def number_to_km(number)
    number_to_currency(number, precision: 0, format: '%n %u', unit: 'km')
  end

  def bootstrap_class_for flash_type
    { success: "alert-success", error: "alert-danger", alert: "alert-warning", notice: "alert-success" }[flash_type.to_sym] || flash_type.to_s
  end

  def flash_messages(opts = {})
    flash.each do |msg_type, message|
      concat(content_tag(:div, message, class: "alert #{bootstrap_class_for(msg_type)} alert-dismissible alert-fix", role: 'alert') do
        concat(content_tag(:button, class: 'close', data: { dismiss: 'alert' }) do
          concat content_tag(:span, '&times;'.html_safe, 'aria-hidden' => true)
          concat content_tag(:span, 'Close', class: 'sr-only')
        end)
        concat message
      end)
    end
    nil
  end

  def published_class(resource)
    resource.published? ? 'text-gray-dark' : 'text-danger'
  end

  def promo_class(resource)
    resource.promo? ? 'text-primary' : ''
  end

  def published_tag(resource)
    if resource.published?
      content_tag(:div, 'Опубліковано', class: 'text-success')
    else
      content_tag(:div, 'Не опубліковано', class: 'text-danger')
    end
  end

  def put_to_ticker_tag(resource)
    if resource.put_to_ticker?
      content_tag(:div, 'Закріплено', class: 'text-success')
    else
      content_tag(:div, 'Не закріплено', class: 'text-danger')
    end
  end

  def promo_tag(resource)
    if resource.promo?
      content_tag(:div, 'Виділено як промо', class: 'text-primary')
    else
      content_tag(:div, 'Не виділено як промо', class: 'text-secondary')
    end
  end

  def label_status_tag(resource) 
    label_class = case resource.label_status
                  when 'in_stock'    then 'badge-status-vnal'
                  when 'sales'       then 'badge-status-prod'
                  when 'reservation' then 'badge-status-reserv'
                  else 
                    nil
                  end

    return if label_class.nil?
    content_tag(:div, t("label_status.#{resource.label_status}"), class: label_class)
  end

  def in_ukraine_tag(resource)
    if resource.in_ukraine?
      content_tag(:div, 'В Україні', class: 'text-primary')
    else
      content_tag(:div, 'Не в Україні', class: 'text-secondary')
    end
  end

  def truncate_markup(text, length = 30, omission = '...', separator = ' ')
    return if text.blank?

    truncate(strip_tags(text), length: length, omission: omission, separator: separator)
  end

  def state_tag(resource) 
    state_class = case resource.state
                  when 'no_broken'    then 'badge-status-no-broken'
                  when 'broken'       then 'badge-status-broken'
                  else 
                    nil
                  end

    return if state_class.nil?
    content_tag(:div, t("state.#{resource.state}"), class: state_class)
  end

  def catalog_custom_path
    ['/catalog', @mark&.slug, @model&.slug].compact.join('/')
  end

  def catalog_custom_url
    request.base_url + catalog_custom_path
  end

  def display_robots_meta_tags
    return unless Car::FILTER_PARAMS.any? {|k| params.keys.map(&:to_sym).include?(k) }

    "<meta name='robots' content='noindex, follow, noarchive' />".html_safe
  end

  def display_pagination_meta_tags
    return unless params['controller'].in?(%w[catalog posts])
    
    if params['controller'] == 'catalog' && params['action'] == 'index'
      load_catalog_meta_tags
    elsif params['controller'] == 'posts' && params['action'] == 'index'
      load_posts_meta_tags
    else
      nil
    end
  end

  private

  def load_catalog_meta_tags
    result = ''
    base_params = catalog_custom_url
    base_params += '?utf8=✓&' if base_params.exclude?('?utf8=✓&')
    base_params += 'page='

    if @cars.prev_page
      result += "<link rel='prev' href=#{base_params + @cars.prev_page.to_s} />"
    end

    if @cars.next_page
      result += "<link rel='next' href=#{base_params + @cars.next_page.to_s} />"
    end

    result.html_safe
  end

  def load_posts_meta_tags
    result = ''
    base_params = request.base_url + '/posts'
    base_params += '?page='

    if @posts.prev_page
      result += "<link rel='prev' href=#{base_params + @posts.prev_page.to_s} />"
    end

    if @posts.next_page
      result += "<link rel='next' href=#{base_params + @posts.next_page.to_s} />"
    end

    result.html_safe
  end
end
