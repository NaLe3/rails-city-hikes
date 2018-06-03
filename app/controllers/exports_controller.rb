class ExportsController < ApplicationController
  before_action :set_route, only: [ :show, :send_route_email, :send_route_phone, :send_route_clipboard, :send_route_gmaps, :send_route_friend]

  def show
    @export = Export.new
    authorize @export
    @gmaps_url = create_gmaps_url
  end

  def send_route_email
    @export = Export.new
    authorize @export
    flash[:notice] = "Route has been sent to your email, #{current_user.first_name}"
    @user = current_user
    @gmaps_url = create_gmaps_url
    ExportRouteMailer.send_route_email(@user, @route, @gmaps_url).deliver_now
    redirect_to route_export_path(@route)
    # redirect_to route_path(@route)
  end

  def send_route_phone
    @export = Export.new
    authorize @export
    flash[:notice] = "Route has been sent to your phone, #{current_user.first_name}"
    # start background job sending a text via API with link
    redirect_to route_export_path(@route)
    # redirect_to route_path(@route)
  end

  def send_route_clipboard
    @export = Export.new
    authorize @export
    flash[:notice] = "Route is now in your clipboard, #{current_user.first_name}"
    # copy to clipboard action
    redirect_to route_export_path(@route)
    # redirect_to route_path(@route)
  end

  # def send_route_gmaps
  #   @export = Export.new
  #   authorize @export
  #   flash[:notice] = "We are opening Google Maps for you, #{@route.user.first_name}"
  #   # open google maps in a new tab
  #   redirect_to route_export_path(@route)
  #   # redirect_to route_path(@route)
  # end

  def send_route_friend
    @export = Export.new
    @friend_name = params[:friend_name]
    @friend_email = params[:friend_email]
    @gmaps_url = create_gmaps_url
    @user = current_user
    authorize @export
    flash[:notice] = "Route has been sent to your friend #{@friend_name}, #{current_user.first_name}"
    ExportRouteMailer.send_route_friend(@user, @route, @gmaps_url, @friend_name, @friend_email).deliver_now
    redirect_to route_export_path(@route)
    # redirect_to route_path(@route)
  end

  private

  def set_route
    @route = Route.find(params[:route_id])
    # authorize @route
  end

  def create_gmaps_url
    base_url    = "https://www.google.com/maps/dir/?api=1"
    origin      = "&origin=#{@route.waypoints.first.sight.latitude},#{@route.waypoints.first.sight.longitude}"
    waypoints   = create_waypoint_url
    destination = "&destination=#{@route.waypoints.last.sight.latitude},#{@route.waypoints.last.sight.longitude}"
    options      = "&travelmode=walking"
    return base_url + origin + destination + waypoints + options
  end

  def create_waypoint_url
    @waypoints = Waypoint.all
    if @route.waypoint_ids.length <= 2
      return ""
    else
      waypoint_url = "&waypoints="
      waypoint_array = @route.waypoint_ids
      waypoint_array.delete_at(waypoint_array.length - 1)
      waypoint_array.delete_at(0)
      waypoint_array.each do |waypoint|
        waypoint_url << "#{@waypoints[waypoint].sight.latitude},#{@waypoints[waypoint].sight.longitude}|"
      end
      return waypoint_url
    end
  end
end
