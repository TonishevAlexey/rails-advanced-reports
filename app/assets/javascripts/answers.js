$(document).on('turbolinks:load', function () {
    console.log("12334455")
    $('.answers').on('click', '.edit-answer-link', function (e) {
        console.log("123")
        e.preventDefault();
        var answerId = $(this).data('answer-id');
        console.log('yuiyi'+answerId)
        $('form#edit-answer-' + answerId).removeClass('hidden');
    })
});