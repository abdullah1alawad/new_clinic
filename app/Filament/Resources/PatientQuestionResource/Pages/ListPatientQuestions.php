<?php

namespace App\Filament\Resources\PatientQuestionResource\Pages;

use App\Filament\Resources\PatientQuestionResource;
use Filament\Actions;
use Filament\Resources\Pages\ListRecords;

class ListPatientQuestions extends ListRecords
{
    protected static string $resource = PatientQuestionResource::class;

    protected function getHeaderActions(): array
    {
        return [
            Actions\CreateAction::make(),
        ];
    }
}
