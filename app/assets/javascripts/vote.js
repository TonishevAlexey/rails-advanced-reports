$(document).on('turbolinks:load', function () {
    $('a.vote-plus').on('ajax:success', function (e) {
        e.preventDefault();

        if (e.detail[0]["class"] === "questions") {
           var elem = document.getElementById('vote-question-' + e.detail[0]["id"]);
           var minus = document.getElementById('vote-minus-question-' + e.detail[0]["id"]);
           var plus = document.getElementById('vote-plus-question-' + e.detail[0]["id"]);
        }else{
            var elem = document.getElementById('vote-' + e.detail[0]["id"]);
            var minus = document.getElementById('vote-minus-' + e.detail[0]["id"]);
            var plus = document.getElementById('vote-plus-' + e.detail[0]["id"]);
        }
        console.log("minus")
        console.log(elem)
        console.log(plus)
        elem.innerHTML = e.detail[0]["value"]
        console.log(plus)
        if (e.detail[0]["kind"] === "plus") {

            plus.classList.add('hidden');
        }
        minus.classList.remove('hidden');

    })
    $('a.vote-minus').on('ajax:success', function (e) {
        e.preventDefault();
        console.log(e.detail[0]["class"])

        if (e.detail[0]["class"] === "questions") {
            elem = document.getElementById('vote-question-' + e.detail[0]["id"]);
            minus = document.getElementById('vote-minus-question-' + e.detail[0]["id"]);
            plus = document.getElementById('vote-plus-question-' + e.detail[0]["id"]);
        }else{
            elem = document.getElementById('vote-' + e.detail[0]["id"]);
            minus = document.getElementById('vote-minus-' + e.detail[0]["id"]);
            plus = document.getElementById('vote-plus-' + e.detail[0]["id"]);
        }        elem.innerHTML = e.detail[0]["value"]
        // console.log("minus")
        console.log(e.detail[0]["class"])
        // console.log("plus")
        if (e.detail[0]["kind"] === "minus") {
            minus.classList.add('hidden');
        }
        plus.classList.remove('hidden');

    })
});