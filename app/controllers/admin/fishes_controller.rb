# frozen_string_literal: true

# AdminFishesController
class Admin::FishesController < Admin::BaseController
  def index
    @fishes = Fish.includes(:location).all
  end

  def show
    @fish = Fish.find(params[:id])
  end

  def edit
    @fish = Fish.find(params[:id])
  end

  def update
    @fish = Fish.find(params[:id])
    if update_fish_successfully?
      handle_successful_update
    else
      handle_failed_update
    end
  end

  private

  def fish_params
    params.require(:fish).permit(
      :name, :image, :image_cache,
      :location_id, :selling_price_tanuki, :selling_price_justin
    )
  end

  def update_fish_successfully?
    @fish.update(fish_params)
  end

  def handle_successful_update
    redirect_to admin_fishes_path, success: t('fishes.update.success', item: Fish.model_name.human)
  end

  def handle_failed_update
    flash.now['danger'] = t('fishes.update.fail', item: Fish.model_name.human)
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
end
