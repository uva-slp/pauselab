module ProposalsHelper
  def get_static_map idea
    url = "https://maps.googleapis.com/maps/api/staticmap?"
    url += "center=#{idea.lat},#{idea.lng}&"
    url += "zoom=17&"
    url += "scale=2&"
    url += "size=600x300&"
    url += "markers=color:red%7C#{idea.lat},#{idea.lng}&"
    url += "key=#{ENV['GOOGLE_API_KEY']}"
  end
end
