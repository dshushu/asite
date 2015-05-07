module ApplicationHelper
  
  def gravatar_for(chef, options = { size:80 })
    size = options[:size]
    gravatar_url = "//placehold.it/#{size}&text=#{size}+%7C+" + chef.chefname
    image_tag gravatar_url, alt: chef.chefname, class: "gravatar"
  end
  
end
