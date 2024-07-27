<?php

namespace App\Filament\Resources;

use App\Filament\Resources\ChairResource\Pages;
use App\Filament\Resources\ChairResource\RelationManagers;
use App\Models\Chair;
use Filament\Forms;
use Filament\Forms\Form;
use Filament\Resources\Resource;
use Filament\Tables;
use Filament\Tables\Table;
use Illuminate\Database\Eloquent\Builder;
use Illuminate\Database\Eloquent\SoftDeletingScope;

class ChairResource extends Resource
{
    protected static ?string $model = Chair::class;

    protected static ?string $navigationIcon = 'heroicon-o-flag';

    protected static ?string $navigationLabel = 'Chair';

    protected static ?string $modelLabel = 'Chair';

    protected static ?string $navigationGroup = 'system management';

    protected static ?int $navigationSort = 5;


    public static function form(Form $form): Form
    {
        return $form
            ->schema([
                Forms\Components\select::make('clinic_id')
                    ->relationship('clinic','name')
                    ->searchable()
                    ->preload()
                    ->required(),
                Forms\Components\TextInput::make('chair_number')
                    ->required()
                    ->numeric(),
            ]);
    }

    public static function table(Table $table): Table
    {
        return $table
            ->columns([
                Tables\Columns\TextColumn::make('clinic_id')
                    ->numeric()
                    ->sortable(),
                Tables\Columns\TextColumn::make('chair_number')
                    ->numeric()
                    ->sortable(),
                Tables\Columns\TextColumn::make('created_at')
                    ->dateTime()
                    ->sortable()
                    ->toggleable(isToggledHiddenByDefault: true),
                Tables\Columns\TextColumn::make('updated_at')
                    ->dateTime()
                    ->sortable()
                    ->toggleable(isToggledHiddenByDefault: true),
            ])
            ->filters([
                //
            ])
            ->actions([
                Tables\Actions\ViewAction::make(),
                Tables\Actions\EditAction::make(),
            ])
            ->bulkActions([
                Tables\Actions\BulkActionGroup::make([
                    Tables\Actions\DeleteBulkAction::make(),
                ]),
            ]);
    }

    public static function getRelations(): array
    {
        return [
            //
        ];
    }

    public static function getPages(): array
    {
        return [
            'index' => Pages\ListChairs::route('/'),
            'create' => Pages\CreateChair::route('/create'),
            'view' => Pages\ViewChair::route('/{record}'),
            'edit' => Pages\EditChair::route('/{record}/edit'),
        ];
    }
}
