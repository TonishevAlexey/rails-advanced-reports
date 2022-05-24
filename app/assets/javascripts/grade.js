$(document).on('turbolinks:load', function () {
    $('a.grade-plus').on('ajax:success', function (e) {
        e.preventDefault();
        elem = document.getElementById('grade-' + e.detail[0]["id"]);
        elem.innerHTML = e.detail[0]["value"]
        plus = document.getElementById('grade-plus-' + e.detail[0]["id"]);
        minus = document.getElementById('grade-minus-' + e.detail[0]["id"]);
        console.log(plus)
        if (e.detail[0]["kind"] === "plus") {

            plus.classList.add('hidden');
        }
        minus.classList.remove('hidden');

    })
    $('a.grade-minus').on('ajax:success', function (e) {
        e.preventDefault();
        elem = document.getElementById('grade-' + e.detail[0]["id"]);
        elem.innerHTML = e.detail[0]["value"]
        minus = document.getElementById('grade-minus-' + e.detail[0]["id"]);
        plus = document.getElementById('grade-plus-' + e.detail[0]["id"]);
        console.log(minus)
        if (e.detail[0]["kind"] === "minus") {
            minus.classList.add('hidden');
        }
        plus.classList.remove('hidden');

    })
    $('a.grade-plus').on('ajax:success', function (e) {
        e.preventDefault();
        elem = document.getElementById('grade-question-' + e.detail[0]["id"]);
        elem.innerHTML = e.detail[0]["value"]
        plus = document.getElementById('grade-plus-question-' + e.detail[0]["id"]);
        minus = document.getElementById('grade-question-minus-' + e.detail[0]["id"]);
        console.log(plus)
        if (e.detail[0]["kind"] === "plus") {

            plus.classList.add('hidden');
        }
        minus.classList.remove('hidden');

    })
    $('a.grade-minus').on('ajax:success', function (e) {
        e.preventDefault();
        elem = document.getElementById('grade-question-' + e.detail[0]["id"]);
        elem.innerHTML = e.detail[0]["value"]
        minus = document.getElementById('grade-question-minus-' + e.detail[0]["id"]);
        plus = document.getElementById('grade-plus-question-' + e.detail[0]["id"]);
        console.log(minus)
        if (e.detail[0]["kind"] === "minus") {
            minus.classList.add('hidden');
        }
        plus.classList.remove('hidden');

    })
});