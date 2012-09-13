module GamesHelper
  def availability_icon(status)
    case status
    when Game::AVAILABILITY_AVAILABLE then content_tag :i, '', class: 'icon-thumbs-up'
    when Game::AVAILABILITY_AVAILABLE then content_tag :i, '', class: 'icon-thumbs-up'
    when Game::AVAILABILITY_AVAILABLE then content_tag :i, '', class: 'icon-thumbs-up'
    end
  end
end
