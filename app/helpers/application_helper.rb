module ApplicationHelper
  
  def gravatar_for(chef, options = { size:80 })
    size = options[:size]
    gravatar_url = "//placehold.it/#{size}x#{size}"
    image_tag gravatar_url, alt: chef.chefname, class: "gravatar"
  end
  
end
