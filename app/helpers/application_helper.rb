module ApplicationHelper
  def default_meta_tags
    {
      site: 'キッチンカー日記',
      title: 'キッチンカーを利用した体験を共有できるレビュー投稿アプリ',
      reverse: true,
      charset: 'utf-8',
      description: '「どのキッチンカーが美味しかったか」「どんな体験ができたか」を投稿・閲覧することで、キッチンカーの魅力を発信します。',
      keywords: 'キッチンカー, フードトラック, 移動販売, グルメ',
      canonical: request.original_url,
      separator: '|',
      og:{
        site_name: :site,
        title: :title,
        description: :description,
        type: 'website',
        url: request.original_url,
        image: image_url('ogp.png'),
        locale: 'ja_JP'
      },
      twitter: {
        card: 'summary_large_image',
        site: '@obvyamdrss',
        image: image_url('ogp.png')
      }
    }
  end
end
