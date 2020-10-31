/// AddFriend router input
protocol AddFriendRouterInput: class {
    func showAlert(
        title: String?,
        message: String?,
        actions: [UIAlertAction],
        preferredStyle: UIAlertController.Style
    )
}
