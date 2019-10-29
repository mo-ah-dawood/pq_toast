library pq_toast;

import 'dart:html';

class Toast {
  static Map<String, String> _getToastsCss() {
    return {
      "display": "inline-block",
      "bottom": "20px",
      "left": "20px",
      "position": "fixed",
      "min-width": "300px",
      "max-width": "100%",
      "width": "35%",
    };
  }

  static Map<String, String> _getToastCss() {
    return {
      "display": "inline-table",
      "color": "#fff",
      "width": "100%",
      "margin-top": "5px",
      "margin-left": "-100%",
      "opacity": "0",
      "transition": "all 0.5s",
      "text-align": "left",
      "overflow": "hidden",
      "border-radius": "3px",
    };
  }

  static Map<String, String> _getSymbolCss(String backGround, String color) {
    return {
      "width": "30px",
      "font-size": "30px",
      "text-align": "center",
      "font-weight": "bold",
      "display": "table-cell",
      "background-color": backGround ?? "#111",
      "vertical-align": "middle",
      "color": color ?? "#fff",
    };
  }

  static Map<String, String> _getTextCss(String backGround, String color) {
    return {
      "color": color ?? "#fff",
      "text-align": "left",
      "display": "table-cell",
      "background-color": backGround ?? "#333",
      "padding": "16px",
      "overflow": "hidden",
      "white-space": "nowrap",
    };
  }

  static void _initToast() {
    var div = querySelector('#toasts');
    if (div == null) {
      var body = querySelector('body');
      div = DivElement()..id = "toasts";
      _getToastsCss().forEach((k, v) => div.style.setProperty(k, v));
      body.children.add(div);
    }
  }

  static void showToast({
    String message,
    String textColor,
    int duration,
    String symbolBgColor,
    String messageBgColor,
    String symbol,
  }) {
    _initToast();
    var toasts = querySelector('#toasts');

    //!parent
    var div = DivElement();
    _getToastCss().forEach((k, v) => div.style.setProperty(k, v));
    //!icon
    var _symbol = DivElement()..text = symbol;
    _getSymbolCss(symbolBgColor, textColor)
        .forEach((k, v) => _symbol.style.setProperty(k, v));
    div.children.add(_symbol);
    //!text
    var text = DivElement()..text = message;
    _getTextCss(messageBgColor, textColor)
        .forEach((k, v) => text.style.setProperty(k, v));
    div.children.add(text);

    //!add and animate
    toasts.children.add(div);
    Future.delayed(Duration(milliseconds: 100)).then((d) {
      div.style.marginLeft = "0%";
      div.style.opacity = "1";
      Future.delayed(Duration(milliseconds: duration ?? 3000)).then((d) {
        div.style.marginLeft = "-100%";
        div.style.opacity = "0";
        Future.delayed(Duration(milliseconds: 500)).then((d) {
          div.remove();
        });
      });
    });
  }

  static void showErrorToast(String message) {
    showToast(
      message: message,
      symbol: "✗",
      symbolBgColor: "#5b0e0e",
      messageBgColor: "#ce4f4f",
    );
  }

  static void showWarningToast(String message) {
    showToast(
      message: message,
      symbol: "⚠",
      symbolBgColor: "#7c6613",
      messageBgColor: "#d7ae15",
    );
  }

  static void showInfoToast(String message) {
    showToast(
      message: message,
      symbol: "!",
      symbolBgColor: "#243a68",
      messageBgColor: "#4f96ce",
    );
  }

  static void showSuccessToast(String message) {
    showToast(
      message: message,
      symbol: "✓",
      symbolBgColor: "#175f28",
      messageBgColor: "#4a995d",
    );
  }
}
