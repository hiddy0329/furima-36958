document.addEventListener("DOMContentLoaded", () => {
const tagNameInput = document.querySelector("#item_form_tag_name");
  if (tagNameInput){
    const inputElement = document.getElementById("item_form_tag_name");
    inputElement.addEventListener("input", () => {
      const keyword = document.getElementById("item_form_tag_name").value;
      // XMLHttpRequestオブジェクトを生成
      const XHR = new XMLHttpRequest();
      // openメソッドでリクエスト先を指定
      XHR.open("GET", `/items/search/?keyword=${keyword}`, true);
      // レスポンスの形式をjsonに設定
      XHR.responseType = "json";
      XHR.send();
      // リクエストが成功したらonloadプロパティに設定した関数を実行
      XHR.onload = () => {
        // レスポンスで帰ってきたkeywordを変数tagNameに代入
        const tagName = XHR.response.keyword;
        // タグを表示させる大枠スペースの要素を取得
        const searchResult = document.getElementById("search-result");
        // 検索結果に引っかかったタグに対し繰り返し処理を行う
        tagName.forEach((tag) => {
          // タグを個別に表示するための要素を生成
          const childElement = document.createElement("div");
          // その要素にclass属性として"child"を設定
          childElement.setAttribute("class", "child");
          // その要素にidとして"tag.id"を設定
          childElement.setAttribute("id", tag.id);
          // タグの名前を要素に埋め込む
          childElement.innerHTML = tag.tag_name;
          // appendChildメソッドで個別要素を大枠要素に入れ込む
          searchResult.appendChild(childElement);
        });
      };
    });
  };
});