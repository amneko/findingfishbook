# frozen_string_literal: true

# ApplicationHelper
module ApplicationHelper
  def default_meta_tags
    {
      site: 'Finding Fish Book',
      title: 'ゲームに出現する魚と実在の水族館をリンクさせるサービス',
      reverse: true,
      charset: 'utf-8',
      description: '『あつまれどうぶつの森』に出現する魚の写真と実際に見ることができる水族館を投稿できます。',
      keywords: '魚,水族館',
      canonical: request.original_url,
      separator: '|',
      og: {
        site_name: :site,
        title: :title,
        description: :description,
        type: 'website',
        url: request.original_url,
        image: image_url('ffb_ogp.png'),
        local: 'ja-JP'
      },
      twitter: {
        card: 'summary_large_image',
        site: '@findingfishbook',
        image: image_url('ffb_ogp.png')
      }
    }
  end

  def fish_to_catch_now
    current_month = Time.zone.now.strftime('%m')
    current_time = Time.zone.now.strftime('%H:%M')
    matching_data = matching_data(current_month, current_time)
    group_fishes_by_location(matching_data)
  end

  private

  def matching_data(month, time)
    NorthAppearance.where(north_month: month)
                   .where(
                     "(? BETWEEN latenight_starttime AND latenight_endtime) OR
                     (? BETWEEN morning_starttime AND morning_endtime) OR
                     (? BETWEEN noon_starttime AND noon_endtime) OR
                     (? BETWEEN evening_starttime AND evening_endtime) OR
                     (? BETWEEN night_starttime AND night_endtime)",
                     time, time, time, time, time
                   )
                   .pluck(:fish_id)
  end

  def group_fishes_by_location(matching_data)
    fishes = Fish.where(id: matching_data).includes(:location)
    fishes.group_by(&:location)
  end
end
