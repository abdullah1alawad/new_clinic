<?php

namespace App\Filament\Resources\PatientQuestionResource\Pages;

use App\Filament\Resources\PatientQuestionResource;
use Filament\Actions;
use Filament\Resources\Pages\EditRecord;

class EditPatientQuestion extends EditRecord
{
    protected static string $resource = PatientQuestionResource::class;

    protected function getHeaderActions(): array
    {
        return [
            Actions\ViewAction::make(),
            Actions\DeleteAction::make(),
        ];
    }
}
