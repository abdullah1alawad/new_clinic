<?php

namespace App\Filament\Resources\PatientQuestionResource\Pages;

use App\Filament\Resources\PatientQuestionResource;
use Filament\Actions;
use Filament\Resources\Pages\CreateRecord;

class CreatePatientQuestion extends CreateRecord
{
    protected static string $resource = PatientQuestionResource::class;
}
