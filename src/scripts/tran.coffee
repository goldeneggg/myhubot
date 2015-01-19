# Description:
#   Allows Hubot to know many languages.
#
# Commands:
#   hubot tran me <phrase> - Searches for a translation for the <phrase> and then prints that bad boy out.
#   hubot tran me from <source> into <target> <phrase> - Translates <phrase> from <source> into <target>. Both <source> and <target> are optional

languages =
  "af": "Afrikaans",
  "sq": "Albanian",
  "ar": "Arabic",
  "az": "Azerbaijani",
  "eu": "Basque",
  "bn": "Bengali",
  "be": "Belarusian",
  "bg": "Bulgarian",
  "ca": "Catalan",
  "zh-CN": "Simplified Chinese",
  "zh-TW": "Traditional Chinese",
  "hr": "Croatian",
  "cs": "Czech",
  "da": "Danish",
  "nl": "Dutch",
  "en": "English",
  "eo": "Esperanto",
  "et": "Estonian",
  "tl": "Filipino",
  "fi": "Finnish",
  "fr": "French",
  "gl": "Galician",
  "ka": "Georgian",
  "de": "German",
  "el": "Greek",
  "gu": "Gujarati",
  "ht": "Haitian Creole",
  "iw": "Hebrew",
  "hi": "Hindi",
  "hu": "Hungarian",
  "is": "Icelandic",
  "id": "Indonesian",
  "ga": "Irish",
  "it": "Italian",
  "ja": "Japanese",
  "kn": "Kannada",
  "ko": "Korean",
  "la": "Latin",
  "lv": "Latvian",
  "lt": "Lithuanian",
  "mk": "Macedonian",
  "ms": "Malay",
  "mt": "Maltese",
  "no": "Norwegian",
  "fa": "Persian",
  "pl": "Polish",
  "pt": "Portuguese",
  "ro": "Romanian",
  "ru": "Russian",
  "sr": "Serbian",
  "sk": "Slovak",
  "sl": "Slovenian",
  "es": "Spanish",
  "sw": "Swahili",
  "sv": "Swedish",
  "ta": "Tamil",
  "te": "Telugu",
  "th": "Thai",
  "tr": "Turkish",
  "uk": "Ukrainian",
  "ur": "Urdu",
  "vi": "Vietnamese",
  "cy": "Welsh",
  "yi": "Yiddish"

module.exports = (robot) ->
  Log = require('../module/Log')(robot.logger)
  H = require('../module/Http')(robot.logger)

  language_choices = (lcd for lcd, language of languages).sort().join('|')
  pattern = new RegExp('tran(?: me)?' +
                       "(?: from (#{language_choices}))?" +
                       "(?: (?:in)?to (#{language_choices}))?" +
                       '(.+)', 'i')

  robot.respond pattern, (msg) ->
    Log.showMatch msg

    term   = "\"#{msg.match[3]}\""
    origin = if msg.match[1] isnt undefined then msg.match[1] else 'auto'
    target = if msg.match[2] isnt undefined then msg.match[2] else 'en'
    url = "https://translate.google.com/translate_a/t?" +
      "client=t" +
      "&hl=en" +
      "&multires=1" +
      "&sc=1" +
      "&sl=#{origin}" +
      "&ssel=0" +
      "&tl=#{target}" +
      "&tsel=0" +
      "&uptl=en" +
      "&text=#{term}"

    callback = (body) ->
      data = body
      if data.length > 4 and data[0] == '['
        parsed = eval(data)
        language =languages[parsed[2]]
        parsed = parsed[0] and parsed[0][0] and parsed[0][0][0]
        if parsed
          if msg.match[2] is undefined
            msg.send "#{term} is #{language} for #{parsed}"
          else
            msg.send "The #{language} #{term} translates as #{parsed} in #{languages[target]}"

    H.get url, callback, false, 8000, {"User-Agent": "Mozilla/5.0"}

