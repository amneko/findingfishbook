# frozen_string_literal: true

# AdminAquariumsController
class Admin::AquariumsController < Admin::BaseController
  def index
    @q = Aquarium.ransack(params[:q])
    @aquariums = @q.result.includes(:prefecture)
  end

  def show
    @aquarium = Aquarium.find(params[:id])
    @fish_in_aquarium = fish_in_aquarium(@aquarium)
    @post_with_aquarium = post_with_aquarium(@aquarium)
  end

  def edit
    @aquarium = Aquarium.find(params[:id])
  end

  def update
    @aquarium = Aquarium.find(params[:id])
    if update_aquarium_successfully?
      handle_successful_update
    else
      handle_failed_update
    end
  end

  private

  def aquarium_params
    params.require(:aquarium).permit(
      :name, :prefecture_id, :address, :website
    )
  end

  def update_aquarium_successfully?
    @aquarium.update(aquarium_params)
  end

  def handle_successful_update
    redirect_to admin_aquariums_path, success: t('aquariums.update.success', item: Aquarium.model_name.human)
  end

  def handle_failed_update
    flash.now['danger'] = t('aquariums.update.fail', item: Aquarium.model_name.human)
    render_or_stream(:edit)
  end

  def render_or_stream(action)
    respond_to do |format|
      format.html { render action, status: :unprocessable_entity }
      format.turbo_stream { render_turbo_stream_flash_message }
    end
  end

  def render_turbo_stream_flash_message
    render turbo_stream: turbo_stream.update(
      'flash',
      partial: 'shared/flash_message',
      locals: { flash: { danger: flash.now[:danger] } }
    )
  end

  def fish_in_aquarium(aquarium)
    Post.where(aquarium_id: aquarium.id).includes(:fish).select(:fish_id).distinct
  end

  def post_with_aquarium(aquarium)
    Post.where(aquarium_id: aquarium.id)
  end
end
