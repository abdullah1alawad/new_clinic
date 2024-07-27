<?php

namespace App\Filament\Resources;

use App\Filament\Resources\PatientQuestionResource\Pages;
use App\Models\Patient_question;
use Filament\Forms;
use Filament\Forms\Components\TextInput;
use Filament\Forms\Components\Toggle;
use Filament\Forms\Form;
use Filament\Resources\Resource;
use Filament\Tables;
use Filament\Tables\Table;

//use Filament\Resources\Table;
use Filament\Tables\Columns\TextColumn;
use Filament\Tables\Columns\BooleanColumn;
use Filament\Tables\Actions\ViewAction;
use Filament\Tables\Actions\EditAction;
use Filament\Tables\Actions\DeleteBulkAction;

class PatientQuestionResource extends Resource
{
    protected static ?string $model = Patient_question::class;

    protected static ?string $navigationIcon = 'heroicon-o-flag';

    protected static ?string $navigationLabel = 'Patient Question';

    protected static ?string $modelLabel = 'Patient Question';

    protected static ?string $navigationGroup = 'system management';

    protected static ?int $navigationSort = 7;

    public static function form(Form $form): Form
    {
        return $form
            ->schema([
                Forms\Components\select::make('clinic_id')
                    ->relationship('clinic', 'name')
                    ->searchable()
                    ->preload()
                    ->required(),
                TextInput::make('question')
                    ->required()
                    ->label('Question'),
                Forms\Components\select::make('validation')
                    ->options([
                        'string' => 'string',
                        'boolean' => 'boolean',
                        'numeric' => 'numeric',
                        'array' => 'array',
                    ])
                    ->required()
                    ->label('Validation'),
                Toggle::make('is_null')
                    ->label('Is Null'),
            ]);
    }

    public static function table(Table $table): Table
    {
        return $table
            ->columns([
                TextColumn::make('clinic_id')
                    ->label('Clinic ID')
                    ->sortable(),
                TextColumn::make('question')
                    ->label('Question')
                    ->sortable(),
                TextColumn::make('validation')
                    ->label('Validation')
                    ->sortable(),
                BooleanColumn::make('is_null')
                    ->label('Is Null'),
                TextColumn::make('created_at')
                    ->label('Created At')
                    ->sortable()
                    ->dateTime(),
                TextColumn::make('updated_at')
                    ->label('Updated At')
                    ->sortable()
                    ->dateTime(),
            ])
            ->filters([
                // Add any filters if needed
            ])
            ->actions([
                ViewAction::make(),
                EditAction::make(),
            ])
            ->bulkActions([
                DeleteBulkAction::make(),
            ]);
    }

    public static function getRelations(): array
    {
        return [
            // Define any relations here if needed
        ];
    }

    public static function getPages(): array
    {
        return [
            'index' => Pages\ListPatientQuestions::route('/'),
            'create' => Pages\CreatePatientQuestion::route('/create'),
            'view' => Pages\ViewPatientQuestion::route('/{record}'),
            'edit' => Pages\EditPatientQuestion::route('/{record}/edit'),
        ];
    }
}
