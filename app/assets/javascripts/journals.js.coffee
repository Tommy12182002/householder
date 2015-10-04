main = ->
  PREFIX = "journals_"
  PREFIX_LEN = PREFIX.length
  UPDATE_FLG = "_update"
  MONTH = $("#month").val 

  # 対象のレコードIDを取得	
  getJournalId = (val) ->
    # 前方のプレフィックスを削除
    val = val.slice(PREFIX_LEN)
    endPos = val.indexOf("_")
    val = val.substr(0, endPos)	
    return val

  # インプット変更時のイベントハンドラ
  $(document).on "change", "#form_edit *", (e) ->
    #対象のレコードの更新フラグを立てる
    journalId = getJournalId(this.id)
    $("#" + PREFIX + journalId + UPDATE_FLG).val(true)

  # Ajaxでの画面遷移時にURLを変更させるための処理
  ###
  changeContents = (url) ->
    $('body').load(url)

  onpoopstate = (e) ->
    changeContents(localtion.pathname)

  $('a').on 'click', (e) ->
    e.preventDefault()
    nextPage = $(this).attr('href')
    changeContents(nextPage)
    window.history.pushState(null, null, nextPage)
    ###

  # 数値専用テキストボックスの制御
  $(document).on 'change', '.integer', (e) ->
    e.preventDefault()
    def = this.defaultValue
    str = this.value
    if str.match(/[^0-9]+/)
      $(this).val(def)


# 初回時と非同期の遷移時に再度読み込み
$(document).ready(main)
$(document).on('page:load', main)
