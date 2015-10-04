main = ->
  # 表示モードと編集モードの切り替え
  toggleEditor = (container) ->
    container.find('.viewer, .editor').toggle()

    $bodyField = container.find('.editor .body')
    if $bodyField.is(':visible')
      $bodyField.val(container.find('.viewer .body').text()).select()


  $('.category').on 'click', '.edit', (e) ->
    toggleEditor $(this).closest('.category')


# 初回時と非同期の遷移時に再度読み込み
$(document).ready(main)
$(document).on('page:load', main)
