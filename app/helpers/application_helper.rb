module ApplicationHelper
  def show_side_menu
    signed_in? ? (render 'layouts/sidemenu/signedin') : (render 'layouts/sidemenu/signedout')
  end
end
