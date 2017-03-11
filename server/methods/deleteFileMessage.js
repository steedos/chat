/* global FileUpload */
Meteor.methods({
	deleteFileMessage: function(fileID) {
		check(fileID, String);

		const msg = RocketChat.models.Messages.getMessageByFileId(fileID);

		if (msg) {
			return Meteor.call('deleteMessage', msg);
		}

		return FileUpload.delete(fileID);
	}
});
