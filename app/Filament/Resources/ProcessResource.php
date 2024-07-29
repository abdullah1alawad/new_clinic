<?php

namespace App\Filament\Resources;

use App\Filament\Resources\ProcessResource\Pages;
use App\Filament\Resources\ProcessResource\RelationManagers;
use App\Models\Clinic;
use App\Models\Patient_question;
use App\Models\Process;
use Filament\Forms;
use Filament\Forms\Form;
use Filament\Resources\Resource;
use Filament\Tables;
use Filament\Tables\Table;
use Illuminate\Database\Eloquent\Builder;
use Illuminate\Database\Eloquent\SoftDeletingScope;
use Symfony\Component\Finder\Iterator\PathFilterIterator;

class ProcessResource extends Resource
{
    protected static ?string $model = Process::class;

    protected static ?string $navigationIcon = 'heroicon-o-flag';

    protected static ?string $navigationLabel = 'Process';

    protected static ?string $modelLabel = 'Process';

    protected static ?string $navigationGroup = 'system management';

    protected static ?int $navigationSort = 8;

    public static function form(Form $form): Form
    {
        $questions = Patient_question::all();
        return $form
            ->schema([

                Forms\Components\Select::make('student_id')
                    ->label('Student')
                    ->relationship('student', 'name', function (Builder $query) {
                        $query->whereHas('roles', function (Builder $query) {
                            $query->where('name', 'student');
                        });
                    })
                    ->searchable()
                    ->preload()
                    ->required(),

                Forms\Components\Select::make('doctor_id')
                    ->label('Doctor')
                    ->relationship('doctor', 'name', function (Builder $query) {
                        $query->whereHas('roles', function (Builder $query) {
                            $query->where('name', 'doctor');
                        });
                    })
                    ->searchable()
                    ->preload()
                    ->required(),

                Forms\Components\Select::make('assistant_id')
                    ->label('Assistant')
                    ->relationship('assistant', 'name', function (Builder $query) {
                        $query->whereHas('roles', function (Builder $query) {
                            $query->where('name', 'assistant');
                        });
                    })
                    ->searchable()
                    ->preload()
                    ->required(),

                Forms\Components\select::make('chair_id')
                    ->relationship('chair', 'chair_number')
                    ->searchable()
                    ->preload()
                    ->required(),
                Forms\Components\select::make('subject_id')
                    ->relationship('subject', 'name')
                    ->searchable()
                    ->preload()
                    ->required(),
//                Forms\Components\Textarea::make('questions')
//                    ->required()
//                    ->columnSpanFull(),

                Forms\Components\Select::make('clinic')
                    ->options(Clinic::all()->pluck('name', 'id'))
                    ->reactive()
                    ->afterStateUpdated(function ($state, callable $set) {
                        $questions = Patient_question::where('clinic_id', $state)->get();
                        $questionsArray = $questions->map(function ($item) {
                            return [
                                'id' => $item->id,
                                'question' => $item->question,
                                'answer' => '',
                            ];
                        })->toArray();
                        $set('questions', $questionsArray); // Set an array
                    })
                    ->required(),

                Forms\Components\Repeater::make('questions')
                    ->schema([
                        Forms\Components\Hidden::make('id'),
                        Forms\Components\TextInput::make('question')
                            ->label('Question')
                            ->disabled(),
                        Forms\Components\TextInput::make('answer')
                            ->label('Answer')
                            ->required(),
                    ])
                    ->label('Questions')
                    ->hidden(fn($get) => empty($get('clinic'))),

                Forms\Components\DateTimePicker::make('date')
                    ->required(),
                Forms\Components\FileUpload::make('photo')
                    ->label('Photo')
                    ->image() // Ensure that only image files can be uploaded
                    ->maxSize(1024) // Maximum file size in KB
                    ->directory('images'),
                Forms\Components\select::make('status')
                    ->options([
                        'rejected',
                        'accepted',
                        'pending',
                    ])
                    ->required(),
//                Forms\Components\TextInput::make('mark')
//                    ->numeric(),
            ]);
    }

    public static function table(Table $table): Table
    {
        return $table
            ->columns([
                Tables\Columns\TextColumn::make('student.name')
                    ->label('Student Name')
                    ->sortable()
                    ->searchable(),
                Tables\Columns\TextColumn::make('doctor.name')
                    ->label('Doctor Name')
                    ->sortable()
                    ->searchable(),
                Tables\Columns\TextColumn::make('assistant.name')
                    ->label('Assistant Name')
                    ->sortable()
                    ->searchable(),
                Tables\Columns\TextColumn::make('chair.chair_number')
                    ->label('Chair Number')
                    ->sortable()
                    ->searchable(),
                Tables\Columns\TextColumn::make('subject.name')
                    ->label('Subject Name')
                    ->sortable()
                    ->searchable(),
                Tables\Columns\TextColumn::make('date')
                    ->dateTime()
                    ->sortable(),
                Tables\Columns\TextColumn::make('photo')
                    ->searchable(),
                Tables\Columns\IconColumn::make('status')
                    ->boolean(),
                Tables\Columns\TextColumn::make('mark')
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
            'index' => Pages\ListProcesses::route('/'),
            'create' => Pages\CreateProcess::route('/create'),
            'view' => Pages\ViewProcess::route('/{record}'),
            'edit' => Pages\EditProcess::route('/{record}/edit'),
        ];
    }
}
