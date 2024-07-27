<?php

namespace App\Filament\Resources;

use App\Filament\Resources\UserScheduleResource\Pages;
use App\Filament\Resources\UserScheduleResource\RelationManagers;
use App\Models\User_schedule;
use Filament\Forms;
use Filament\Forms\Form;
use Filament\Resources\Resource;
use Filament\Tables;
use Filament\Tables\Table;
use Illuminate\Database\Eloquent\Builder;
use Illuminate\Database\Eloquent\SoftDeletingScope;

class UserScheduleResource extends Resource
{
    protected static ?string $model = User_schedule::class;

    protected static ?string $navigationIcon = 'heroicon-o-flag';

    protected static ?string $navigationLabel = 'User Schedule';

    protected static ?string $modelLabel = 'User Schedule';

    protected static ?string $navigationGroup = 'system management';

    protected static ?int $navigationSort = 3;

    public static function form(Form $form): Form
    {
        return $form
            ->schema([
                //
            ]);
    }

    public static function table(Table $table): Table
    {
        return $table
            ->columns([
                //
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
            'index' => Pages\ListUserSchedules::route('/'),
            'create' => Pages\CreateUserSchedule::route('/create'),
            'view' => Pages\ViewUserSchedule::route('/{record}'),
            'edit' => Pages\EditUserSchedule::route('/{record}/edit'),
        ];
    }
}
