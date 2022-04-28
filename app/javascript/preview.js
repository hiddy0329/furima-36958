document.addEventListener('DOMContentLoaded', function(){
  // 新規投稿・編集ページのフォームを取得
  const postForm = document.getElementById('new-post');
  const editForm = document.getElementById('edit-post');
  // プレビューを表示するためのスペースを取得
  const previewList = document.getElementById('previews');
  // 新規投稿・編集ページのフォームがないならここで終了。
  if (!postForm && !editForm) return null;

  // input要素を取得
  const fileField = document.querySelector('input[type="file"][name="item[image]"]');
  // input要素で値の変化が起きた際に次の関数を呼び出す
  fileField.addEventListener('change', function(e){
    // 古いプレビューが存在する場合は削除
    const alreadyPreview = document.querySelector('.preview');
    if (alreadyPreview) {
      alreadyPreview.remove();
    };
    // e.target.files[0]により、指定した引数の中のデータを取得する
    const file = e.target.files[0];
    // createObjectURLメソッドで画像データのURLを取得する
    const blob = window.URL.createObjectURL(file);
    // 画像を表示するためのdiv要素を生成(createElementメソッド)
    const previewWrapper = document.createElement('div');
    previewWrapper.setAttribute('class', 'preview');
    // 表示する画像を生成
    const previewImage = document.createElement('img');
    previewImage.setAttribute('class', 'preview-image');
    previewImage.setAttribute('src', blob);
    // 生成したHTMLの要素をブラウザに表示させる
    previewWrapper.appendChild(previewImage);
    previewList.appendChild(previewWrapper);
  });
});