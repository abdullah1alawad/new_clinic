<?php

use Illuminate\Support\Facades\Broadcast;

/*
|--------------------------------------------------------------------------
| Broadcast Channels
|--------------------------------------------------------------------------
|
| Here you may register all of the event broadcasting channels that your
| application supports. The given channel authorization callbacks are
| used to check if an authenticated user can listen to the channel.
|
*/

Broadcast::channel('chat.{id}', function ($user, $id) {

    $participant = \App\Models\ChatParticipant::where([
        [
            'user_id', $user->id,
        ],
        [
            'chat_id', $id
        ]
    ])->first();

    return $participant !== null;
});

Broadcast::channel('App.User.{id}', function ($user, $id) {
    return $user->id == $id;
});

//Broadcast::channel('notifications.{userId}', function ($user, $userId) {
//    return (int) $user->id === (int) $userId;
//});

Broadcast::channel('notifications.{id}', function ($user, $id) {
    \Log::info('Broadcast channel authorization:', ['user_id' => $user->id, 'channel_id' => $id]);
    return (int)$user->id === (int)$id;
});
