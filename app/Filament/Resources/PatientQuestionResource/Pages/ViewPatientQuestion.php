<?php

namespace App\Filament\Resources\PatientQuestionResource\Pages;

use App\Filament\Resources\PatientQuestionResource;
use Filament\Actions;
use Filament\Resources\Pages\ViewRecord;

class ViewPatientQuestion extends ViewRecord
{
    protected static string $resource = PatientQuestionResource::class;

    protected function getHeaderActions(): array
    {
        return [
            Actions\EditAction::make(),
        ];
    }
}
