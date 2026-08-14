// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $TrabajadoresTable extends Trabajadores
    with TableInfo<$TrabajadoresTable, Trabajadore> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TrabajadoresTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _nombreMeta = const VerificationMeta('nombre');
  @override
  late final GeneratedColumn<String> nombre = GeneratedColumn<String>(
    'nombre',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 120,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _dniMeta = const VerificationMeta('dni');
  @override
  late final GeneratedColumn<String> dni = GeneratedColumn<String>(
    'dni',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 8,
      maxTextLength: 8,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'),
  );
  static const VerificationMeta _telefonoMeta = const VerificationMeta(
    'telefono',
  );
  @override
  late final GeneratedColumn<String> telefono = GeneratedColumn<String>(
    'telefono',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _cargoMeta = const VerificationMeta('cargo');
  @override
  late final GeneratedColumn<String> cargo = GeneratedColumn<String>(
    'cargo',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('Chofer'),
  );
  static const VerificationMeta _fechaIngresoMeta = const VerificationMeta(
    'fechaIngreso',
  );
  @override
  late final GeneratedColumn<DateTime> fechaIngreso = GeneratedColumn<DateTime>(
    'fecha_ingreso',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _activoMeta = const VerificationMeta('activo');
  @override
  late final GeneratedColumn<bool> activo = GeneratedColumn<bool>(
    'activo',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("activo" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    nombre,
    dni,
    telefono,
    cargo,
    fechaIngreso,
    activo,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'trabajadores';
  @override
  VerificationContext validateIntegrity(
    Insertable<Trabajadore> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('nombre')) {
      context.handle(
        _nombreMeta,
        nombre.isAcceptableOrUnknown(data['nombre']!, _nombreMeta),
      );
    } else if (isInserting) {
      context.missing(_nombreMeta);
    }
    if (data.containsKey('dni')) {
      context.handle(
        _dniMeta,
        dni.isAcceptableOrUnknown(data['dni']!, _dniMeta),
      );
    } else if (isInserting) {
      context.missing(_dniMeta);
    }
    if (data.containsKey('telefono')) {
      context.handle(
        _telefonoMeta,
        telefono.isAcceptableOrUnknown(data['telefono']!, _telefonoMeta),
      );
    }
    if (data.containsKey('cargo')) {
      context.handle(
        _cargoMeta,
        cargo.isAcceptableOrUnknown(data['cargo']!, _cargoMeta),
      );
    }
    if (data.containsKey('fecha_ingreso')) {
      context.handle(
        _fechaIngresoMeta,
        fechaIngreso.isAcceptableOrUnknown(
          data['fecha_ingreso']!,
          _fechaIngresoMeta,
        ),
      );
    }
    if (data.containsKey('activo')) {
      context.handle(
        _activoMeta,
        activo.isAcceptableOrUnknown(data['activo']!, _activoMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Trabajadore map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Trabajadore(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      nombre: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}nombre'],
      )!,
      dni: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}dni'],
      )!,
      telefono: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}telefono'],
      ),
      cargo: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}cargo'],
      )!,
      fechaIngreso: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}fecha_ingreso'],
      ),
      activo: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}activo'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $TrabajadoresTable createAlias(String alias) {
    return $TrabajadoresTable(attachedDatabase, alias);
  }
}

class Trabajadore extends DataClass implements Insertable<Trabajadore> {
  final int id;
  final String nombre;

  /// DNI de 8 dígitos, único — evita duplicados y datos mal tipeados.
  final String dni;
  final String? telefono;
  final String cargo;
  final DateTime? fechaIngreso;
  final bool activo;
  final DateTime createdAt;
  final DateTime updatedAt;
  const Trabajadore({
    required this.id,
    required this.nombre,
    required this.dni,
    this.telefono,
    required this.cargo,
    this.fechaIngreso,
    required this.activo,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['nombre'] = Variable<String>(nombre);
    map['dni'] = Variable<String>(dni);
    if (!nullToAbsent || telefono != null) {
      map['telefono'] = Variable<String>(telefono);
    }
    map['cargo'] = Variable<String>(cargo);
    if (!nullToAbsent || fechaIngreso != null) {
      map['fecha_ingreso'] = Variable<DateTime>(fechaIngreso);
    }
    map['activo'] = Variable<bool>(activo);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  TrabajadoresCompanion toCompanion(bool nullToAbsent) {
    return TrabajadoresCompanion(
      id: Value(id),
      nombre: Value(nombre),
      dni: Value(dni),
      telefono: telefono == null && nullToAbsent
          ? const Value.absent()
          : Value(telefono),
      cargo: Value(cargo),
      fechaIngreso: fechaIngreso == null && nullToAbsent
          ? const Value.absent()
          : Value(fechaIngreso),
      activo: Value(activo),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory Trabajadore.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Trabajadore(
      id: serializer.fromJson<int>(json['id']),
      nombre: serializer.fromJson<String>(json['nombre']),
      dni: serializer.fromJson<String>(json['dni']),
      telefono: serializer.fromJson<String?>(json['telefono']),
      cargo: serializer.fromJson<String>(json['cargo']),
      fechaIngreso: serializer.fromJson<DateTime?>(json['fechaIngreso']),
      activo: serializer.fromJson<bool>(json['activo']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'nombre': serializer.toJson<String>(nombre),
      'dni': serializer.toJson<String>(dni),
      'telefono': serializer.toJson<String?>(telefono),
      'cargo': serializer.toJson<String>(cargo),
      'fechaIngreso': serializer.toJson<DateTime?>(fechaIngreso),
      'activo': serializer.toJson<bool>(activo),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  Trabajadore copyWith({
    int? id,
    String? nombre,
    String? dni,
    Value<String?> telefono = const Value.absent(),
    String? cargo,
    Value<DateTime?> fechaIngreso = const Value.absent(),
    bool? activo,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => Trabajadore(
    id: id ?? this.id,
    nombre: nombre ?? this.nombre,
    dni: dni ?? this.dni,
    telefono: telefono.present ? telefono.value : this.telefono,
    cargo: cargo ?? this.cargo,
    fechaIngreso: fechaIngreso.present ? fechaIngreso.value : this.fechaIngreso,
    activo: activo ?? this.activo,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  Trabajadore copyWithCompanion(TrabajadoresCompanion data) {
    return Trabajadore(
      id: data.id.present ? data.id.value : this.id,
      nombre: data.nombre.present ? data.nombre.value : this.nombre,
      dni: data.dni.present ? data.dni.value : this.dni,
      telefono: data.telefono.present ? data.telefono.value : this.telefono,
      cargo: data.cargo.present ? data.cargo.value : this.cargo,
      fechaIngreso: data.fechaIngreso.present
          ? data.fechaIngreso.value
          : this.fechaIngreso,
      activo: data.activo.present ? data.activo.value : this.activo,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Trabajadore(')
          ..write('id: $id, ')
          ..write('nombre: $nombre, ')
          ..write('dni: $dni, ')
          ..write('telefono: $telefono, ')
          ..write('cargo: $cargo, ')
          ..write('fechaIngreso: $fechaIngreso, ')
          ..write('activo: $activo, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    nombre,
    dni,
    telefono,
    cargo,
    fechaIngreso,
    activo,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Trabajadore &&
          other.id == this.id &&
          other.nombre == this.nombre &&
          other.dni == this.dni &&
          other.telefono == this.telefono &&
          other.cargo == this.cargo &&
          other.fechaIngreso == this.fechaIngreso &&
          other.activo == this.activo &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class TrabajadoresCompanion extends UpdateCompanion<Trabajadore> {
  final Value<int> id;
  final Value<String> nombre;
  final Value<String> dni;
  final Value<String?> telefono;
  final Value<String> cargo;
  final Value<DateTime?> fechaIngreso;
  final Value<bool> activo;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  const TrabajadoresCompanion({
    this.id = const Value.absent(),
    this.nombre = const Value.absent(),
    this.dni = const Value.absent(),
    this.telefono = const Value.absent(),
    this.cargo = const Value.absent(),
    this.fechaIngreso = const Value.absent(),
    this.activo = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  TrabajadoresCompanion.insert({
    this.id = const Value.absent(),
    required String nombre,
    required String dni,
    this.telefono = const Value.absent(),
    this.cargo = const Value.absent(),
    this.fechaIngreso = const Value.absent(),
    this.activo = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  }) : nombre = Value(nombre),
       dni = Value(dni);
  static Insertable<Trabajadore> custom({
    Expression<int>? id,
    Expression<String>? nombre,
    Expression<String>? dni,
    Expression<String>? telefono,
    Expression<String>? cargo,
    Expression<DateTime>? fechaIngreso,
    Expression<bool>? activo,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (nombre != null) 'nombre': nombre,
      if (dni != null) 'dni': dni,
      if (telefono != null) 'telefono': telefono,
      if (cargo != null) 'cargo': cargo,
      if (fechaIngreso != null) 'fecha_ingreso': fechaIngreso,
      if (activo != null) 'activo': activo,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  TrabajadoresCompanion copyWith({
    Value<int>? id,
    Value<String>? nombre,
    Value<String>? dni,
    Value<String?>? telefono,
    Value<String>? cargo,
    Value<DateTime?>? fechaIngreso,
    Value<bool>? activo,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
  }) {
    return TrabajadoresCompanion(
      id: id ?? this.id,
      nombre: nombre ?? this.nombre,
      dni: dni ?? this.dni,
      telefono: telefono ?? this.telefono,
      cargo: cargo ?? this.cargo,
      fechaIngreso: fechaIngreso ?? this.fechaIngreso,
      activo: activo ?? this.activo,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (nombre.present) {
      map['nombre'] = Variable<String>(nombre.value);
    }
    if (dni.present) {
      map['dni'] = Variable<String>(dni.value);
    }
    if (telefono.present) {
      map['telefono'] = Variable<String>(telefono.value);
    }
    if (cargo.present) {
      map['cargo'] = Variable<String>(cargo.value);
    }
    if (fechaIngreso.present) {
      map['fecha_ingreso'] = Variable<DateTime>(fechaIngreso.value);
    }
    if (activo.present) {
      map['activo'] = Variable<bool>(activo.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TrabajadoresCompanion(')
          ..write('id: $id, ')
          ..write('nombre: $nombre, ')
          ..write('dni: $dni, ')
          ..write('telefono: $telefono, ')
          ..write('cargo: $cargo, ')
          ..write('fechaIngreso: $fechaIngreso, ')
          ..write('activo: $activo, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

class $VehiculosTable extends Vehiculos
    with TableInfo<$VehiculosTable, Vehiculo> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $VehiculosTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _placaMeta = const VerificationMeta('placa');
  @override
  late final GeneratedColumn<String> placa = GeneratedColumn<String>(
    'placa',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 5,
      maxTextLength: 10,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'),
  );
  static const VerificationMeta _tipoMeta = const VerificationMeta('tipo');
  @override
  late final GeneratedColumn<String> tipo = GeneratedColumn<String>(
    'tipo',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _marcaMeta = const VerificationMeta('marca');
  @override
  late final GeneratedColumn<String> marca = GeneratedColumn<String>(
    'marca',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _modeloMeta = const VerificationMeta('modelo');
  @override
  late final GeneratedColumn<String> modelo = GeneratedColumn<String>(
    'modelo',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _anioMeta = const VerificationMeta('anio');
  @override
  late final GeneratedColumn<int> anio = GeneratedColumn<int>(
    'anio',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _soatVencimientoMeta = const VerificationMeta(
    'soatVencimiento',
  );
  @override
  late final GeneratedColumn<DateTime> soatVencimiento =
      GeneratedColumn<DateTime>(
        'soat_vencimiento',
        aliasedName,
        true,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _revisionTecnicaVencimientoMeta =
      const VerificationMeta('revisionTecnicaVencimiento');
  @override
  late final GeneratedColumn<DateTime> revisionTecnicaVencimiento =
      GeneratedColumn<DateTime>(
        'revision_tecnica_vencimiento',
        aliasedName,
        true,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: false,
      );
  @override
  late final GeneratedColumnWithTypeConverter<VehiculoEstado, int> estado =
      GeneratedColumn<int>(
        'estado',
        aliasedName,
        false,
        type: DriftSqlType.int,
        requiredDuringInsert: false,
        defaultValue: Constant(VehiculoEstado.activo.index),
      ).withConverter<VehiculoEstado>($VehiculosTable.$converterestado);
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    placa,
    tipo,
    marca,
    modelo,
    anio,
    soatVencimiento,
    revisionTecnicaVencimiento,
    estado,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'vehiculos';
  @override
  VerificationContext validateIntegrity(
    Insertable<Vehiculo> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('placa')) {
      context.handle(
        _placaMeta,
        placa.isAcceptableOrUnknown(data['placa']!, _placaMeta),
      );
    } else if (isInserting) {
      context.missing(_placaMeta);
    }
    if (data.containsKey('tipo')) {
      context.handle(
        _tipoMeta,
        tipo.isAcceptableOrUnknown(data['tipo']!, _tipoMeta),
      );
    } else if (isInserting) {
      context.missing(_tipoMeta);
    }
    if (data.containsKey('marca')) {
      context.handle(
        _marcaMeta,
        marca.isAcceptableOrUnknown(data['marca']!, _marcaMeta),
      );
    }
    if (data.containsKey('modelo')) {
      context.handle(
        _modeloMeta,
        modelo.isAcceptableOrUnknown(data['modelo']!, _modeloMeta),
      );
    }
    if (data.containsKey('anio')) {
      context.handle(
        _anioMeta,
        anio.isAcceptableOrUnknown(data['anio']!, _anioMeta),
      );
    }
    if (data.containsKey('soat_vencimiento')) {
      context.handle(
        _soatVencimientoMeta,
        soatVencimiento.isAcceptableOrUnknown(
          data['soat_vencimiento']!,
          _soatVencimientoMeta,
        ),
      );
    }
    if (data.containsKey('revision_tecnica_vencimiento')) {
      context.handle(
        _revisionTecnicaVencimientoMeta,
        revisionTecnicaVencimiento.isAcceptableOrUnknown(
          data['revision_tecnica_vencimiento']!,
          _revisionTecnicaVencimientoMeta,
        ),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Vehiculo map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Vehiculo(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      placa: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}placa'],
      )!,
      tipo: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}tipo'],
      )!,
      marca: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}marca'],
      ),
      modelo: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}modelo'],
      ),
      anio: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}anio'],
      ),
      soatVencimiento: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}soat_vencimiento'],
      ),
      revisionTecnicaVencimiento: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}revision_tecnica_vencimiento'],
      ),
      estado: $VehiculosTable.$converterestado.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.int,
          data['${effectivePrefix}estado'],
        )!,
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $VehiculosTable createAlias(String alias) {
    return $VehiculosTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<VehiculoEstado, int, int> $converterestado =
      const EnumIndexConverter<VehiculoEstado>(VehiculoEstado.values);
}

class Vehiculo extends DataClass implements Insertable<Vehiculo> {
  final int id;

  /// Placa única — evita confundir dos unidades en un reporte.
  final String placa;
  final String tipo;
  final String? marca;
  final String? modelo;
  final int? anio;
  final DateTime? soatVencimiento;
  final DateTime? revisionTecnicaVencimiento;
  final VehiculoEstado estado;
  final DateTime createdAt;
  final DateTime updatedAt;
  const Vehiculo({
    required this.id,
    required this.placa,
    required this.tipo,
    this.marca,
    this.modelo,
    this.anio,
    this.soatVencimiento,
    this.revisionTecnicaVencimiento,
    required this.estado,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['placa'] = Variable<String>(placa);
    map['tipo'] = Variable<String>(tipo);
    if (!nullToAbsent || marca != null) {
      map['marca'] = Variable<String>(marca);
    }
    if (!nullToAbsent || modelo != null) {
      map['modelo'] = Variable<String>(modelo);
    }
    if (!nullToAbsent || anio != null) {
      map['anio'] = Variable<int>(anio);
    }
    if (!nullToAbsent || soatVencimiento != null) {
      map['soat_vencimiento'] = Variable<DateTime>(soatVencimiento);
    }
    if (!nullToAbsent || revisionTecnicaVencimiento != null) {
      map['revision_tecnica_vencimiento'] = Variable<DateTime>(
        revisionTecnicaVencimiento,
      );
    }
    {
      map['estado'] = Variable<int>(
        $VehiculosTable.$converterestado.toSql(estado),
      );
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  VehiculosCompanion toCompanion(bool nullToAbsent) {
    return VehiculosCompanion(
      id: Value(id),
      placa: Value(placa),
      tipo: Value(tipo),
      marca: marca == null && nullToAbsent
          ? const Value.absent()
          : Value(marca),
      modelo: modelo == null && nullToAbsent
          ? const Value.absent()
          : Value(modelo),
      anio: anio == null && nullToAbsent ? const Value.absent() : Value(anio),
      soatVencimiento: soatVencimiento == null && nullToAbsent
          ? const Value.absent()
          : Value(soatVencimiento),
      revisionTecnicaVencimiento:
          revisionTecnicaVencimiento == null && nullToAbsent
          ? const Value.absent()
          : Value(revisionTecnicaVencimiento),
      estado: Value(estado),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory Vehiculo.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Vehiculo(
      id: serializer.fromJson<int>(json['id']),
      placa: serializer.fromJson<String>(json['placa']),
      tipo: serializer.fromJson<String>(json['tipo']),
      marca: serializer.fromJson<String?>(json['marca']),
      modelo: serializer.fromJson<String?>(json['modelo']),
      anio: serializer.fromJson<int?>(json['anio']),
      soatVencimiento: serializer.fromJson<DateTime?>(json['soatVencimiento']),
      revisionTecnicaVencimiento: serializer.fromJson<DateTime?>(
        json['revisionTecnicaVencimiento'],
      ),
      estado: $VehiculosTable.$converterestado.fromJson(
        serializer.fromJson<int>(json['estado']),
      ),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'placa': serializer.toJson<String>(placa),
      'tipo': serializer.toJson<String>(tipo),
      'marca': serializer.toJson<String?>(marca),
      'modelo': serializer.toJson<String?>(modelo),
      'anio': serializer.toJson<int?>(anio),
      'soatVencimiento': serializer.toJson<DateTime?>(soatVencimiento),
      'revisionTecnicaVencimiento': serializer.toJson<DateTime?>(
        revisionTecnicaVencimiento,
      ),
      'estado': serializer.toJson<int>(
        $VehiculosTable.$converterestado.toJson(estado),
      ),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  Vehiculo copyWith({
    int? id,
    String? placa,
    String? tipo,
    Value<String?> marca = const Value.absent(),
    Value<String?> modelo = const Value.absent(),
    Value<int?> anio = const Value.absent(),
    Value<DateTime?> soatVencimiento = const Value.absent(),
    Value<DateTime?> revisionTecnicaVencimiento = const Value.absent(),
    VehiculoEstado? estado,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => Vehiculo(
    id: id ?? this.id,
    placa: placa ?? this.placa,
    tipo: tipo ?? this.tipo,
    marca: marca.present ? marca.value : this.marca,
    modelo: modelo.present ? modelo.value : this.modelo,
    anio: anio.present ? anio.value : this.anio,
    soatVencimiento: soatVencimiento.present
        ? soatVencimiento.value
        : this.soatVencimiento,
    revisionTecnicaVencimiento: revisionTecnicaVencimiento.present
        ? revisionTecnicaVencimiento.value
        : this.revisionTecnicaVencimiento,
    estado: estado ?? this.estado,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  Vehiculo copyWithCompanion(VehiculosCompanion data) {
    return Vehiculo(
      id: data.id.present ? data.id.value : this.id,
      placa: data.placa.present ? data.placa.value : this.placa,
      tipo: data.tipo.present ? data.tipo.value : this.tipo,
      marca: data.marca.present ? data.marca.value : this.marca,
      modelo: data.modelo.present ? data.modelo.value : this.modelo,
      anio: data.anio.present ? data.anio.value : this.anio,
      soatVencimiento: data.soatVencimiento.present
          ? data.soatVencimiento.value
          : this.soatVencimiento,
      revisionTecnicaVencimiento: data.revisionTecnicaVencimiento.present
          ? data.revisionTecnicaVencimiento.value
          : this.revisionTecnicaVencimiento,
      estado: data.estado.present ? data.estado.value : this.estado,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Vehiculo(')
          ..write('id: $id, ')
          ..write('placa: $placa, ')
          ..write('tipo: $tipo, ')
          ..write('marca: $marca, ')
          ..write('modelo: $modelo, ')
          ..write('anio: $anio, ')
          ..write('soatVencimiento: $soatVencimiento, ')
          ..write('revisionTecnicaVencimiento: $revisionTecnicaVencimiento, ')
          ..write('estado: $estado, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    placa,
    tipo,
    marca,
    modelo,
    anio,
    soatVencimiento,
    revisionTecnicaVencimiento,
    estado,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Vehiculo &&
          other.id == this.id &&
          other.placa == this.placa &&
          other.tipo == this.tipo &&
          other.marca == this.marca &&
          other.modelo == this.modelo &&
          other.anio == this.anio &&
          other.soatVencimiento == this.soatVencimiento &&
          other.revisionTecnicaVencimiento == this.revisionTecnicaVencimiento &&
          other.estado == this.estado &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class VehiculosCompanion extends UpdateCompanion<Vehiculo> {
  final Value<int> id;
  final Value<String> placa;
  final Value<String> tipo;
  final Value<String?> marca;
  final Value<String?> modelo;
  final Value<int?> anio;
  final Value<DateTime?> soatVencimiento;
  final Value<DateTime?> revisionTecnicaVencimiento;
  final Value<VehiculoEstado> estado;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  const VehiculosCompanion({
    this.id = const Value.absent(),
    this.placa = const Value.absent(),
    this.tipo = const Value.absent(),
    this.marca = const Value.absent(),
    this.modelo = const Value.absent(),
    this.anio = const Value.absent(),
    this.soatVencimiento = const Value.absent(),
    this.revisionTecnicaVencimiento = const Value.absent(),
    this.estado = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  VehiculosCompanion.insert({
    this.id = const Value.absent(),
    required String placa,
    required String tipo,
    this.marca = const Value.absent(),
    this.modelo = const Value.absent(),
    this.anio = const Value.absent(),
    this.soatVencimiento = const Value.absent(),
    this.revisionTecnicaVencimiento = const Value.absent(),
    this.estado = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  }) : placa = Value(placa),
       tipo = Value(tipo);
  static Insertable<Vehiculo> custom({
    Expression<int>? id,
    Expression<String>? placa,
    Expression<String>? tipo,
    Expression<String>? marca,
    Expression<String>? modelo,
    Expression<int>? anio,
    Expression<DateTime>? soatVencimiento,
    Expression<DateTime>? revisionTecnicaVencimiento,
    Expression<int>? estado,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (placa != null) 'placa': placa,
      if (tipo != null) 'tipo': tipo,
      if (marca != null) 'marca': marca,
      if (modelo != null) 'modelo': modelo,
      if (anio != null) 'anio': anio,
      if (soatVencimiento != null) 'soat_vencimiento': soatVencimiento,
      if (revisionTecnicaVencimiento != null)
        'revision_tecnica_vencimiento': revisionTecnicaVencimiento,
      if (estado != null) 'estado': estado,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  VehiculosCompanion copyWith({
    Value<int>? id,
    Value<String>? placa,
    Value<String>? tipo,
    Value<String?>? marca,
    Value<String?>? modelo,
    Value<int?>? anio,
    Value<DateTime?>? soatVencimiento,
    Value<DateTime?>? revisionTecnicaVencimiento,
    Value<VehiculoEstado>? estado,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
  }) {
    return VehiculosCompanion(
      id: id ?? this.id,
      placa: placa ?? this.placa,
      tipo: tipo ?? this.tipo,
      marca: marca ?? this.marca,
      modelo: modelo ?? this.modelo,
      anio: anio ?? this.anio,
      soatVencimiento: soatVencimiento ?? this.soatVencimiento,
      revisionTecnicaVencimiento:
          revisionTecnicaVencimiento ?? this.revisionTecnicaVencimiento,
      estado: estado ?? this.estado,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (placa.present) {
      map['placa'] = Variable<String>(placa.value);
    }
    if (tipo.present) {
      map['tipo'] = Variable<String>(tipo.value);
    }
    if (marca.present) {
      map['marca'] = Variable<String>(marca.value);
    }
    if (modelo.present) {
      map['modelo'] = Variable<String>(modelo.value);
    }
    if (anio.present) {
      map['anio'] = Variable<int>(anio.value);
    }
    if (soatVencimiento.present) {
      map['soat_vencimiento'] = Variable<DateTime>(soatVencimiento.value);
    }
    if (revisionTecnicaVencimiento.present) {
      map['revision_tecnica_vencimiento'] = Variable<DateTime>(
        revisionTecnicaVencimiento.value,
      );
    }
    if (estado.present) {
      map['estado'] = Variable<int>(
        $VehiculosTable.$converterestado.toSql(estado.value),
      );
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('VehiculosCompanion(')
          ..write('id: $id, ')
          ..write('placa: $placa, ')
          ..write('tipo: $tipo, ')
          ..write('marca: $marca, ')
          ..write('modelo: $modelo, ')
          ..write('anio: $anio, ')
          ..write('soatVencimiento: $soatVencimiento, ')
          ..write('revisionTecnicaVencimiento: $revisionTecnicaVencimiento, ')
          ..write('estado: $estado, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

class $ViajesTable extends Viajes with TableInfo<$ViajesTable, Viaje> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ViajesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _fechaSalidaMeta = const VerificationMeta(
    'fechaSalida',
  );
  @override
  late final GeneratedColumn<DateTime> fechaSalida = GeneratedColumn<DateTime>(
    'fecha_salida',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _fechaLlegadaMeta = const VerificationMeta(
    'fechaLlegada',
  );
  @override
  late final GeneratedColumn<DateTime> fechaLlegada = GeneratedColumn<DateTime>(
    'fecha_llegada',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _origenMeta = const VerificationMeta('origen');
  @override
  late final GeneratedColumn<String> origen = GeneratedColumn<String>(
    'origen',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _destinoMeta = const VerificationMeta(
    'destino',
  );
  @override
  late final GeneratedColumn<String> destino = GeneratedColumn<String>(
    'destino',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _clienteMeta = const VerificationMeta(
    'cliente',
  );
  @override
  late final GeneratedColumn<String> cliente = GeneratedColumn<String>(
    'cliente',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('KR'),
  );
  static const VerificationMeta _cargaMeta = const VerificationMeta('carga');
  @override
  late final GeneratedColumn<String> carga = GeneratedColumn<String>(
    'carga',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _kilometrajeMeta = const VerificationMeta(
    'kilometraje',
  );
  @override
  late final GeneratedColumn<double> kilometraje = GeneratedColumn<double>(
    'kilometraje',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _trabajadorIdMeta = const VerificationMeta(
    'trabajadorId',
  );
  @override
  late final GeneratedColumn<int> trabajadorId = GeneratedColumn<int>(
    'trabajador_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES trabajadores (id)',
    ),
  );
  static const VerificationMeta _vehiculoIdMeta = const VerificationMeta(
    'vehiculoId',
  );
  @override
  late final GeneratedColumn<int> vehiculoId = GeneratedColumn<int>(
    'vehiculo_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES vehiculos (id)',
    ),
  );
  @override
  late final GeneratedColumnWithTypeConverter<ViajeEstado, int> estado =
      GeneratedColumn<int>(
        'estado',
        aliasedName,
        false,
        type: DriftSqlType.int,
        requiredDuringInsert: false,
        defaultValue: Constant(ViajeEstado.programado.index),
      ).withConverter<ViajeEstado>($ViajesTable.$converterestado);
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    fechaSalida,
    fechaLlegada,
    origen,
    destino,
    cliente,
    carga,
    kilometraje,
    trabajadorId,
    vehiculoId,
    estado,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'viajes';
  @override
  VerificationContext validateIntegrity(
    Insertable<Viaje> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('fecha_salida')) {
      context.handle(
        _fechaSalidaMeta,
        fechaSalida.isAcceptableOrUnknown(
          data['fecha_salida']!,
          _fechaSalidaMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_fechaSalidaMeta);
    }
    if (data.containsKey('fecha_llegada')) {
      context.handle(
        _fechaLlegadaMeta,
        fechaLlegada.isAcceptableOrUnknown(
          data['fecha_llegada']!,
          _fechaLlegadaMeta,
        ),
      );
    }
    if (data.containsKey('origen')) {
      context.handle(
        _origenMeta,
        origen.isAcceptableOrUnknown(data['origen']!, _origenMeta),
      );
    } else if (isInserting) {
      context.missing(_origenMeta);
    }
    if (data.containsKey('destino')) {
      context.handle(
        _destinoMeta,
        destino.isAcceptableOrUnknown(data['destino']!, _destinoMeta),
      );
    } else if (isInserting) {
      context.missing(_destinoMeta);
    }
    if (data.containsKey('cliente')) {
      context.handle(
        _clienteMeta,
        cliente.isAcceptableOrUnknown(data['cliente']!, _clienteMeta),
      );
    }
    if (data.containsKey('carga')) {
      context.handle(
        _cargaMeta,
        carga.isAcceptableOrUnknown(data['carga']!, _cargaMeta),
      );
    }
    if (data.containsKey('kilometraje')) {
      context.handle(
        _kilometrajeMeta,
        kilometraje.isAcceptableOrUnknown(
          data['kilometraje']!,
          _kilometrajeMeta,
        ),
      );
    }
    if (data.containsKey('trabajador_id')) {
      context.handle(
        _trabajadorIdMeta,
        trabajadorId.isAcceptableOrUnknown(
          data['trabajador_id']!,
          _trabajadorIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_trabajadorIdMeta);
    }
    if (data.containsKey('vehiculo_id')) {
      context.handle(
        _vehiculoIdMeta,
        vehiculoId.isAcceptableOrUnknown(data['vehiculo_id']!, _vehiculoIdMeta),
      );
    } else if (isInserting) {
      context.missing(_vehiculoIdMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Viaje map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Viaje(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      fechaSalida: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}fecha_salida'],
      )!,
      fechaLlegada: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}fecha_llegada'],
      ),
      origen: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}origen'],
      )!,
      destino: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}destino'],
      )!,
      cliente: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}cliente'],
      )!,
      carga: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}carga'],
      ),
      kilometraje: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}kilometraje'],
      ),
      trabajadorId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}trabajador_id'],
      )!,
      vehiculoId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}vehiculo_id'],
      )!,
      estado: $ViajesTable.$converterestado.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.int,
          data['${effectivePrefix}estado'],
        )!,
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $ViajesTable createAlias(String alias) {
    return $ViajesTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<ViajeEstado, int, int> $converterestado =
      const EnumIndexConverter<ViajeEstado>(ViajeEstado.values);
}

class Viaje extends DataClass implements Insertable<Viaje> {
  final int id;
  final DateTime fechaSalida;

  /// Nula mientras el viaje no haya terminado.
  final DateTime? fechaLlegada;
  final String origen;
  final String destino;
  final String cliente;
  final String? carga;
  final double? kilometraje;
  final int trabajadorId;
  final int vehiculoId;
  final ViajeEstado estado;
  final DateTime createdAt;
  final DateTime updatedAt;
  const Viaje({
    required this.id,
    required this.fechaSalida,
    this.fechaLlegada,
    required this.origen,
    required this.destino,
    required this.cliente,
    this.carga,
    this.kilometraje,
    required this.trabajadorId,
    required this.vehiculoId,
    required this.estado,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['fecha_salida'] = Variable<DateTime>(fechaSalida);
    if (!nullToAbsent || fechaLlegada != null) {
      map['fecha_llegada'] = Variable<DateTime>(fechaLlegada);
    }
    map['origen'] = Variable<String>(origen);
    map['destino'] = Variable<String>(destino);
    map['cliente'] = Variable<String>(cliente);
    if (!nullToAbsent || carga != null) {
      map['carga'] = Variable<String>(carga);
    }
    if (!nullToAbsent || kilometraje != null) {
      map['kilometraje'] = Variable<double>(kilometraje);
    }
    map['trabajador_id'] = Variable<int>(trabajadorId);
    map['vehiculo_id'] = Variable<int>(vehiculoId);
    {
      map['estado'] = Variable<int>(
        $ViajesTable.$converterestado.toSql(estado),
      );
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  ViajesCompanion toCompanion(bool nullToAbsent) {
    return ViajesCompanion(
      id: Value(id),
      fechaSalida: Value(fechaSalida),
      fechaLlegada: fechaLlegada == null && nullToAbsent
          ? const Value.absent()
          : Value(fechaLlegada),
      origen: Value(origen),
      destino: Value(destino),
      cliente: Value(cliente),
      carga: carga == null && nullToAbsent
          ? const Value.absent()
          : Value(carga),
      kilometraje: kilometraje == null && nullToAbsent
          ? const Value.absent()
          : Value(kilometraje),
      trabajadorId: Value(trabajadorId),
      vehiculoId: Value(vehiculoId),
      estado: Value(estado),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory Viaje.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Viaje(
      id: serializer.fromJson<int>(json['id']),
      fechaSalida: serializer.fromJson<DateTime>(json['fechaSalida']),
      fechaLlegada: serializer.fromJson<DateTime?>(json['fechaLlegada']),
      origen: serializer.fromJson<String>(json['origen']),
      destino: serializer.fromJson<String>(json['destino']),
      cliente: serializer.fromJson<String>(json['cliente']),
      carga: serializer.fromJson<String?>(json['carga']),
      kilometraje: serializer.fromJson<double?>(json['kilometraje']),
      trabajadorId: serializer.fromJson<int>(json['trabajadorId']),
      vehiculoId: serializer.fromJson<int>(json['vehiculoId']),
      estado: $ViajesTable.$converterestado.fromJson(
        serializer.fromJson<int>(json['estado']),
      ),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'fechaSalida': serializer.toJson<DateTime>(fechaSalida),
      'fechaLlegada': serializer.toJson<DateTime?>(fechaLlegada),
      'origen': serializer.toJson<String>(origen),
      'destino': serializer.toJson<String>(destino),
      'cliente': serializer.toJson<String>(cliente),
      'carga': serializer.toJson<String?>(carga),
      'kilometraje': serializer.toJson<double?>(kilometraje),
      'trabajadorId': serializer.toJson<int>(trabajadorId),
      'vehiculoId': serializer.toJson<int>(vehiculoId),
      'estado': serializer.toJson<int>(
        $ViajesTable.$converterestado.toJson(estado),
      ),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  Viaje copyWith({
    int? id,
    DateTime? fechaSalida,
    Value<DateTime?> fechaLlegada = const Value.absent(),
    String? origen,
    String? destino,
    String? cliente,
    Value<String?> carga = const Value.absent(),
    Value<double?> kilometraje = const Value.absent(),
    int? trabajadorId,
    int? vehiculoId,
    ViajeEstado? estado,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => Viaje(
    id: id ?? this.id,
    fechaSalida: fechaSalida ?? this.fechaSalida,
    fechaLlegada: fechaLlegada.present ? fechaLlegada.value : this.fechaLlegada,
    origen: origen ?? this.origen,
    destino: destino ?? this.destino,
    cliente: cliente ?? this.cliente,
    carga: carga.present ? carga.value : this.carga,
    kilometraje: kilometraje.present ? kilometraje.value : this.kilometraje,
    trabajadorId: trabajadorId ?? this.trabajadorId,
    vehiculoId: vehiculoId ?? this.vehiculoId,
    estado: estado ?? this.estado,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  Viaje copyWithCompanion(ViajesCompanion data) {
    return Viaje(
      id: data.id.present ? data.id.value : this.id,
      fechaSalida: data.fechaSalida.present
          ? data.fechaSalida.value
          : this.fechaSalida,
      fechaLlegada: data.fechaLlegada.present
          ? data.fechaLlegada.value
          : this.fechaLlegada,
      origen: data.origen.present ? data.origen.value : this.origen,
      destino: data.destino.present ? data.destino.value : this.destino,
      cliente: data.cliente.present ? data.cliente.value : this.cliente,
      carga: data.carga.present ? data.carga.value : this.carga,
      kilometraje: data.kilometraje.present
          ? data.kilometraje.value
          : this.kilometraje,
      trabajadorId: data.trabajadorId.present
          ? data.trabajadorId.value
          : this.trabajadorId,
      vehiculoId: data.vehiculoId.present
          ? data.vehiculoId.value
          : this.vehiculoId,
      estado: data.estado.present ? data.estado.value : this.estado,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Viaje(')
          ..write('id: $id, ')
          ..write('fechaSalida: $fechaSalida, ')
          ..write('fechaLlegada: $fechaLlegada, ')
          ..write('origen: $origen, ')
          ..write('destino: $destino, ')
          ..write('cliente: $cliente, ')
          ..write('carga: $carga, ')
          ..write('kilometraje: $kilometraje, ')
          ..write('trabajadorId: $trabajadorId, ')
          ..write('vehiculoId: $vehiculoId, ')
          ..write('estado: $estado, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    fechaSalida,
    fechaLlegada,
    origen,
    destino,
    cliente,
    carga,
    kilometraje,
    trabajadorId,
    vehiculoId,
    estado,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Viaje &&
          other.id == this.id &&
          other.fechaSalida == this.fechaSalida &&
          other.fechaLlegada == this.fechaLlegada &&
          other.origen == this.origen &&
          other.destino == this.destino &&
          other.cliente == this.cliente &&
          other.carga == this.carga &&
          other.kilometraje == this.kilometraje &&
          other.trabajadorId == this.trabajadorId &&
          other.vehiculoId == this.vehiculoId &&
          other.estado == this.estado &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class ViajesCompanion extends UpdateCompanion<Viaje> {
  final Value<int> id;
  final Value<DateTime> fechaSalida;
  final Value<DateTime?> fechaLlegada;
  final Value<String> origen;
  final Value<String> destino;
  final Value<String> cliente;
  final Value<String?> carga;
  final Value<double?> kilometraje;
  final Value<int> trabajadorId;
  final Value<int> vehiculoId;
  final Value<ViajeEstado> estado;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  const ViajesCompanion({
    this.id = const Value.absent(),
    this.fechaSalida = const Value.absent(),
    this.fechaLlegada = const Value.absent(),
    this.origen = const Value.absent(),
    this.destino = const Value.absent(),
    this.cliente = const Value.absent(),
    this.carga = const Value.absent(),
    this.kilometraje = const Value.absent(),
    this.trabajadorId = const Value.absent(),
    this.vehiculoId = const Value.absent(),
    this.estado = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  ViajesCompanion.insert({
    this.id = const Value.absent(),
    required DateTime fechaSalida,
    this.fechaLlegada = const Value.absent(),
    required String origen,
    required String destino,
    this.cliente = const Value.absent(),
    this.carga = const Value.absent(),
    this.kilometraje = const Value.absent(),
    required int trabajadorId,
    required int vehiculoId,
    this.estado = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  }) : fechaSalida = Value(fechaSalida),
       origen = Value(origen),
       destino = Value(destino),
       trabajadorId = Value(trabajadorId),
       vehiculoId = Value(vehiculoId);
  static Insertable<Viaje> custom({
    Expression<int>? id,
    Expression<DateTime>? fechaSalida,
    Expression<DateTime>? fechaLlegada,
    Expression<String>? origen,
    Expression<String>? destino,
    Expression<String>? cliente,
    Expression<String>? carga,
    Expression<double>? kilometraje,
    Expression<int>? trabajadorId,
    Expression<int>? vehiculoId,
    Expression<int>? estado,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (fechaSalida != null) 'fecha_salida': fechaSalida,
      if (fechaLlegada != null) 'fecha_llegada': fechaLlegada,
      if (origen != null) 'origen': origen,
      if (destino != null) 'destino': destino,
      if (cliente != null) 'cliente': cliente,
      if (carga != null) 'carga': carga,
      if (kilometraje != null) 'kilometraje': kilometraje,
      if (trabajadorId != null) 'trabajador_id': trabajadorId,
      if (vehiculoId != null) 'vehiculo_id': vehiculoId,
      if (estado != null) 'estado': estado,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  ViajesCompanion copyWith({
    Value<int>? id,
    Value<DateTime>? fechaSalida,
    Value<DateTime?>? fechaLlegada,
    Value<String>? origen,
    Value<String>? destino,
    Value<String>? cliente,
    Value<String?>? carga,
    Value<double?>? kilometraje,
    Value<int>? trabajadorId,
    Value<int>? vehiculoId,
    Value<ViajeEstado>? estado,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
  }) {
    return ViajesCompanion(
      id: id ?? this.id,
      fechaSalida: fechaSalida ?? this.fechaSalida,
      fechaLlegada: fechaLlegada ?? this.fechaLlegada,
      origen: origen ?? this.origen,
      destino: destino ?? this.destino,
      cliente: cliente ?? this.cliente,
      carga: carga ?? this.carga,
      kilometraje: kilometraje ?? this.kilometraje,
      trabajadorId: trabajadorId ?? this.trabajadorId,
      vehiculoId: vehiculoId ?? this.vehiculoId,
      estado: estado ?? this.estado,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (fechaSalida.present) {
      map['fecha_salida'] = Variable<DateTime>(fechaSalida.value);
    }
    if (fechaLlegada.present) {
      map['fecha_llegada'] = Variable<DateTime>(fechaLlegada.value);
    }
    if (origen.present) {
      map['origen'] = Variable<String>(origen.value);
    }
    if (destino.present) {
      map['destino'] = Variable<String>(destino.value);
    }
    if (cliente.present) {
      map['cliente'] = Variable<String>(cliente.value);
    }
    if (carga.present) {
      map['carga'] = Variable<String>(carga.value);
    }
    if (kilometraje.present) {
      map['kilometraje'] = Variable<double>(kilometraje.value);
    }
    if (trabajadorId.present) {
      map['trabajador_id'] = Variable<int>(trabajadorId.value);
    }
    if (vehiculoId.present) {
      map['vehiculo_id'] = Variable<int>(vehiculoId.value);
    }
    if (estado.present) {
      map['estado'] = Variable<int>(
        $ViajesTable.$converterestado.toSql(estado.value),
      );
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ViajesCompanion(')
          ..write('id: $id, ')
          ..write('fechaSalida: $fechaSalida, ')
          ..write('fechaLlegada: $fechaLlegada, ')
          ..write('origen: $origen, ')
          ..write('destino: $destino, ')
          ..write('cliente: $cliente, ')
          ..write('carga: $carga, ')
          ..write('kilometraje: $kilometraje, ')
          ..write('trabajadorId: $trabajadorId, ')
          ..write('vehiculoId: $vehiculoId, ')
          ..write('estado: $estado, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

class $IngresosTable extends Ingresos with TableInfo<$IngresosTable, Ingreso> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $IngresosTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _montoMeta = const VerificationMeta('monto');
  @override
  late final GeneratedColumn<double> monto = GeneratedColumn<double>(
    'monto',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _fechaMeta = const VerificationMeta('fecha');
  @override
  late final GeneratedColumn<DateTime> fecha = GeneratedColumn<DateTime>(
    'fecha',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _conceptoMeta = const VerificationMeta(
    'concepto',
  );
  @override
  late final GeneratedColumn<String> concepto = GeneratedColumn<String>(
    'concepto',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _viajeIdMeta = const VerificationMeta(
    'viajeId',
  );
  @override
  late final GeneratedColumn<int> viajeId = GeneratedColumn<int>(
    'viaje_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES viajes (id)',
    ),
  );
  static const VerificationMeta _comprobantePathMeta = const VerificationMeta(
    'comprobantePath',
  );
  @override
  late final GeneratedColumn<String> comprobantePath = GeneratedColumn<String>(
    'comprobante_path',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    monto,
    fecha,
    concepto,
    viajeId,
    comprobantePath,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'ingresos';
  @override
  VerificationContext validateIntegrity(
    Insertable<Ingreso> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('monto')) {
      context.handle(
        _montoMeta,
        monto.isAcceptableOrUnknown(data['monto']!, _montoMeta),
      );
    } else if (isInserting) {
      context.missing(_montoMeta);
    }
    if (data.containsKey('fecha')) {
      context.handle(
        _fechaMeta,
        fecha.isAcceptableOrUnknown(data['fecha']!, _fechaMeta),
      );
    } else if (isInserting) {
      context.missing(_fechaMeta);
    }
    if (data.containsKey('concepto')) {
      context.handle(
        _conceptoMeta,
        concepto.isAcceptableOrUnknown(data['concepto']!, _conceptoMeta),
      );
    } else if (isInserting) {
      context.missing(_conceptoMeta);
    }
    if (data.containsKey('viaje_id')) {
      context.handle(
        _viajeIdMeta,
        viajeId.isAcceptableOrUnknown(data['viaje_id']!, _viajeIdMeta),
      );
    }
    if (data.containsKey('comprobante_path')) {
      context.handle(
        _comprobantePathMeta,
        comprobantePath.isAcceptableOrUnknown(
          data['comprobante_path']!,
          _comprobantePathMeta,
        ),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Ingreso map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Ingreso(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      monto: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}monto'],
      )!,
      fecha: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}fecha'],
      )!,
      concepto: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}concepto'],
      )!,
      viajeId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}viaje_id'],
      ),
      comprobantePath: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}comprobante_path'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $IngresosTable createAlias(String alias) {
    return $IngresosTable(attachedDatabase, alias);
  }
}

class Ingreso extends DataClass implements Insertable<Ingreso> {
  final int id;
  final double monto;
  final DateTime fecha;
  final String concepto;
  final int? viajeId;

  /// Ruta local a la foto de la boleta/factura, si se adjuntó una.
  final String? comprobantePath;
  final DateTime createdAt;
  final DateTime updatedAt;
  const Ingreso({
    required this.id,
    required this.monto,
    required this.fecha,
    required this.concepto,
    this.viajeId,
    this.comprobantePath,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['monto'] = Variable<double>(monto);
    map['fecha'] = Variable<DateTime>(fecha);
    map['concepto'] = Variable<String>(concepto);
    if (!nullToAbsent || viajeId != null) {
      map['viaje_id'] = Variable<int>(viajeId);
    }
    if (!nullToAbsent || comprobantePath != null) {
      map['comprobante_path'] = Variable<String>(comprobantePath);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  IngresosCompanion toCompanion(bool nullToAbsent) {
    return IngresosCompanion(
      id: Value(id),
      monto: Value(monto),
      fecha: Value(fecha),
      concepto: Value(concepto),
      viajeId: viajeId == null && nullToAbsent
          ? const Value.absent()
          : Value(viajeId),
      comprobantePath: comprobantePath == null && nullToAbsent
          ? const Value.absent()
          : Value(comprobantePath),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory Ingreso.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Ingreso(
      id: serializer.fromJson<int>(json['id']),
      monto: serializer.fromJson<double>(json['monto']),
      fecha: serializer.fromJson<DateTime>(json['fecha']),
      concepto: serializer.fromJson<String>(json['concepto']),
      viajeId: serializer.fromJson<int?>(json['viajeId']),
      comprobantePath: serializer.fromJson<String?>(json['comprobantePath']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'monto': serializer.toJson<double>(monto),
      'fecha': serializer.toJson<DateTime>(fecha),
      'concepto': serializer.toJson<String>(concepto),
      'viajeId': serializer.toJson<int?>(viajeId),
      'comprobantePath': serializer.toJson<String?>(comprobantePath),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  Ingreso copyWith({
    int? id,
    double? monto,
    DateTime? fecha,
    String? concepto,
    Value<int?> viajeId = const Value.absent(),
    Value<String?> comprobantePath = const Value.absent(),
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => Ingreso(
    id: id ?? this.id,
    monto: monto ?? this.monto,
    fecha: fecha ?? this.fecha,
    concepto: concepto ?? this.concepto,
    viajeId: viajeId.present ? viajeId.value : this.viajeId,
    comprobantePath: comprobantePath.present
        ? comprobantePath.value
        : this.comprobantePath,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  Ingreso copyWithCompanion(IngresosCompanion data) {
    return Ingreso(
      id: data.id.present ? data.id.value : this.id,
      monto: data.monto.present ? data.monto.value : this.monto,
      fecha: data.fecha.present ? data.fecha.value : this.fecha,
      concepto: data.concepto.present ? data.concepto.value : this.concepto,
      viajeId: data.viajeId.present ? data.viajeId.value : this.viajeId,
      comprobantePath: data.comprobantePath.present
          ? data.comprobantePath.value
          : this.comprobantePath,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Ingreso(')
          ..write('id: $id, ')
          ..write('monto: $monto, ')
          ..write('fecha: $fecha, ')
          ..write('concepto: $concepto, ')
          ..write('viajeId: $viajeId, ')
          ..write('comprobantePath: $comprobantePath, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    monto,
    fecha,
    concepto,
    viajeId,
    comprobantePath,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Ingreso &&
          other.id == this.id &&
          other.monto == this.monto &&
          other.fecha == this.fecha &&
          other.concepto == this.concepto &&
          other.viajeId == this.viajeId &&
          other.comprobantePath == this.comprobantePath &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class IngresosCompanion extends UpdateCompanion<Ingreso> {
  final Value<int> id;
  final Value<double> monto;
  final Value<DateTime> fecha;
  final Value<String> concepto;
  final Value<int?> viajeId;
  final Value<String?> comprobantePath;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  const IngresosCompanion({
    this.id = const Value.absent(),
    this.monto = const Value.absent(),
    this.fecha = const Value.absent(),
    this.concepto = const Value.absent(),
    this.viajeId = const Value.absent(),
    this.comprobantePath = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  IngresosCompanion.insert({
    this.id = const Value.absent(),
    required double monto,
    required DateTime fecha,
    required String concepto,
    this.viajeId = const Value.absent(),
    this.comprobantePath = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  }) : monto = Value(monto),
       fecha = Value(fecha),
       concepto = Value(concepto);
  static Insertable<Ingreso> custom({
    Expression<int>? id,
    Expression<double>? monto,
    Expression<DateTime>? fecha,
    Expression<String>? concepto,
    Expression<int>? viajeId,
    Expression<String>? comprobantePath,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (monto != null) 'monto': monto,
      if (fecha != null) 'fecha': fecha,
      if (concepto != null) 'concepto': concepto,
      if (viajeId != null) 'viaje_id': viajeId,
      if (comprobantePath != null) 'comprobante_path': comprobantePath,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  IngresosCompanion copyWith({
    Value<int>? id,
    Value<double>? monto,
    Value<DateTime>? fecha,
    Value<String>? concepto,
    Value<int?>? viajeId,
    Value<String?>? comprobantePath,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
  }) {
    return IngresosCompanion(
      id: id ?? this.id,
      monto: monto ?? this.monto,
      fecha: fecha ?? this.fecha,
      concepto: concepto ?? this.concepto,
      viajeId: viajeId ?? this.viajeId,
      comprobantePath: comprobantePath ?? this.comprobantePath,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (monto.present) {
      map['monto'] = Variable<double>(monto.value);
    }
    if (fecha.present) {
      map['fecha'] = Variable<DateTime>(fecha.value);
    }
    if (concepto.present) {
      map['concepto'] = Variable<String>(concepto.value);
    }
    if (viajeId.present) {
      map['viaje_id'] = Variable<int>(viajeId.value);
    }
    if (comprobantePath.present) {
      map['comprobante_path'] = Variable<String>(comprobantePath.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('IngresosCompanion(')
          ..write('id: $id, ')
          ..write('monto: $monto, ')
          ..write('fecha: $fecha, ')
          ..write('concepto: $concepto, ')
          ..write('viajeId: $viajeId, ')
          ..write('comprobantePath: $comprobantePath, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

class $EgresosTable extends Egresos with TableInfo<$EgresosTable, Egreso> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $EgresosTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _montoMeta = const VerificationMeta('monto');
  @override
  late final GeneratedColumn<double> monto = GeneratedColumn<double>(
    'monto',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _fechaMeta = const VerificationMeta('fecha');
  @override
  late final GeneratedColumn<DateTime> fecha = GeneratedColumn<DateTime>(
    'fecha',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  late final GeneratedColumnWithTypeConverter<EgresoCategoria, int> categoria =
      GeneratedColumn<int>(
        'categoria',
        aliasedName,
        false,
        type: DriftSqlType.int,
        requiredDuringInsert: true,
      ).withConverter<EgresoCategoria>($EgresosTable.$convertercategoria);
  static const VerificationMeta _descripcionMeta = const VerificationMeta(
    'descripcion',
  );
  @override
  late final GeneratedColumn<String> descripcion = GeneratedColumn<String>(
    'descripcion',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _viajeIdMeta = const VerificationMeta(
    'viajeId',
  );
  @override
  late final GeneratedColumn<int> viajeId = GeneratedColumn<int>(
    'viaje_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES viajes (id)',
    ),
  );
  static const VerificationMeta _vehiculoIdMeta = const VerificationMeta(
    'vehiculoId',
  );
  @override
  late final GeneratedColumn<int> vehiculoId = GeneratedColumn<int>(
    'vehiculo_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES vehiculos (id)',
    ),
  );
  static const VerificationMeta _comprobantePathMeta = const VerificationMeta(
    'comprobantePath',
  );
  @override
  late final GeneratedColumn<String> comprobantePath = GeneratedColumn<String>(
    'comprobante_path',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    monto,
    fecha,
    categoria,
    descripcion,
    viajeId,
    vehiculoId,
    comprobantePath,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'egresos';
  @override
  VerificationContext validateIntegrity(
    Insertable<Egreso> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('monto')) {
      context.handle(
        _montoMeta,
        monto.isAcceptableOrUnknown(data['monto']!, _montoMeta),
      );
    } else if (isInserting) {
      context.missing(_montoMeta);
    }
    if (data.containsKey('fecha')) {
      context.handle(
        _fechaMeta,
        fecha.isAcceptableOrUnknown(data['fecha']!, _fechaMeta),
      );
    } else if (isInserting) {
      context.missing(_fechaMeta);
    }
    if (data.containsKey('descripcion')) {
      context.handle(
        _descripcionMeta,
        descripcion.isAcceptableOrUnknown(
          data['descripcion']!,
          _descripcionMeta,
        ),
      );
    }
    if (data.containsKey('viaje_id')) {
      context.handle(
        _viajeIdMeta,
        viajeId.isAcceptableOrUnknown(data['viaje_id']!, _viajeIdMeta),
      );
    }
    if (data.containsKey('vehiculo_id')) {
      context.handle(
        _vehiculoIdMeta,
        vehiculoId.isAcceptableOrUnknown(data['vehiculo_id']!, _vehiculoIdMeta),
      );
    }
    if (data.containsKey('comprobante_path')) {
      context.handle(
        _comprobantePathMeta,
        comprobantePath.isAcceptableOrUnknown(
          data['comprobante_path']!,
          _comprobantePathMeta,
        ),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Egreso map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Egreso(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      monto: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}monto'],
      )!,
      fecha: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}fecha'],
      )!,
      categoria: $EgresosTable.$convertercategoria.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.int,
          data['${effectivePrefix}categoria'],
        )!,
      ),
      descripcion: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}descripcion'],
      ),
      viajeId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}viaje_id'],
      ),
      vehiculoId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}vehiculo_id'],
      ),
      comprobantePath: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}comprobante_path'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $EgresosTable createAlias(String alias) {
    return $EgresosTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<EgresoCategoria, int, int> $convertercategoria =
      const EnumIndexConverter<EgresoCategoria>(EgresoCategoria.values);
}

class Egreso extends DataClass implements Insertable<Egreso> {
  final int id;
  final double monto;
  final DateTime fecha;
  final EgresoCategoria categoria;
  final String? descripcion;
  final int? viajeId;
  final int? vehiculoId;
  final String? comprobantePath;
  final DateTime createdAt;
  final DateTime updatedAt;
  const Egreso({
    required this.id,
    required this.monto,
    required this.fecha,
    required this.categoria,
    this.descripcion,
    this.viajeId,
    this.vehiculoId,
    this.comprobantePath,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['monto'] = Variable<double>(monto);
    map['fecha'] = Variable<DateTime>(fecha);
    {
      map['categoria'] = Variable<int>(
        $EgresosTable.$convertercategoria.toSql(categoria),
      );
    }
    if (!nullToAbsent || descripcion != null) {
      map['descripcion'] = Variable<String>(descripcion);
    }
    if (!nullToAbsent || viajeId != null) {
      map['viaje_id'] = Variable<int>(viajeId);
    }
    if (!nullToAbsent || vehiculoId != null) {
      map['vehiculo_id'] = Variable<int>(vehiculoId);
    }
    if (!nullToAbsent || comprobantePath != null) {
      map['comprobante_path'] = Variable<String>(comprobantePath);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  EgresosCompanion toCompanion(bool nullToAbsent) {
    return EgresosCompanion(
      id: Value(id),
      monto: Value(monto),
      fecha: Value(fecha),
      categoria: Value(categoria),
      descripcion: descripcion == null && nullToAbsent
          ? const Value.absent()
          : Value(descripcion),
      viajeId: viajeId == null && nullToAbsent
          ? const Value.absent()
          : Value(viajeId),
      vehiculoId: vehiculoId == null && nullToAbsent
          ? const Value.absent()
          : Value(vehiculoId),
      comprobantePath: comprobantePath == null && nullToAbsent
          ? const Value.absent()
          : Value(comprobantePath),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory Egreso.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Egreso(
      id: serializer.fromJson<int>(json['id']),
      monto: serializer.fromJson<double>(json['monto']),
      fecha: serializer.fromJson<DateTime>(json['fecha']),
      categoria: $EgresosTable.$convertercategoria.fromJson(
        serializer.fromJson<int>(json['categoria']),
      ),
      descripcion: serializer.fromJson<String?>(json['descripcion']),
      viajeId: serializer.fromJson<int?>(json['viajeId']),
      vehiculoId: serializer.fromJson<int?>(json['vehiculoId']),
      comprobantePath: serializer.fromJson<String?>(json['comprobantePath']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'monto': serializer.toJson<double>(monto),
      'fecha': serializer.toJson<DateTime>(fecha),
      'categoria': serializer.toJson<int>(
        $EgresosTable.$convertercategoria.toJson(categoria),
      ),
      'descripcion': serializer.toJson<String?>(descripcion),
      'viajeId': serializer.toJson<int?>(viajeId),
      'vehiculoId': serializer.toJson<int?>(vehiculoId),
      'comprobantePath': serializer.toJson<String?>(comprobantePath),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  Egreso copyWith({
    int? id,
    double? monto,
    DateTime? fecha,
    EgresoCategoria? categoria,
    Value<String?> descripcion = const Value.absent(),
    Value<int?> viajeId = const Value.absent(),
    Value<int?> vehiculoId = const Value.absent(),
    Value<String?> comprobantePath = const Value.absent(),
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => Egreso(
    id: id ?? this.id,
    monto: monto ?? this.monto,
    fecha: fecha ?? this.fecha,
    categoria: categoria ?? this.categoria,
    descripcion: descripcion.present ? descripcion.value : this.descripcion,
    viajeId: viajeId.present ? viajeId.value : this.viajeId,
    vehiculoId: vehiculoId.present ? vehiculoId.value : this.vehiculoId,
    comprobantePath: comprobantePath.present
        ? comprobantePath.value
        : this.comprobantePath,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  Egreso copyWithCompanion(EgresosCompanion data) {
    return Egreso(
      id: data.id.present ? data.id.value : this.id,
      monto: data.monto.present ? data.monto.value : this.monto,
      fecha: data.fecha.present ? data.fecha.value : this.fecha,
      categoria: data.categoria.present ? data.categoria.value : this.categoria,
      descripcion: data.descripcion.present
          ? data.descripcion.value
          : this.descripcion,
      viajeId: data.viajeId.present ? data.viajeId.value : this.viajeId,
      vehiculoId: data.vehiculoId.present
          ? data.vehiculoId.value
          : this.vehiculoId,
      comprobantePath: data.comprobantePath.present
          ? data.comprobantePath.value
          : this.comprobantePath,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Egreso(')
          ..write('id: $id, ')
          ..write('monto: $monto, ')
          ..write('fecha: $fecha, ')
          ..write('categoria: $categoria, ')
          ..write('descripcion: $descripcion, ')
          ..write('viajeId: $viajeId, ')
          ..write('vehiculoId: $vehiculoId, ')
          ..write('comprobantePath: $comprobantePath, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    monto,
    fecha,
    categoria,
    descripcion,
    viajeId,
    vehiculoId,
    comprobantePath,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Egreso &&
          other.id == this.id &&
          other.monto == this.monto &&
          other.fecha == this.fecha &&
          other.categoria == this.categoria &&
          other.descripcion == this.descripcion &&
          other.viajeId == this.viajeId &&
          other.vehiculoId == this.vehiculoId &&
          other.comprobantePath == this.comprobantePath &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class EgresosCompanion extends UpdateCompanion<Egreso> {
  final Value<int> id;
  final Value<double> monto;
  final Value<DateTime> fecha;
  final Value<EgresoCategoria> categoria;
  final Value<String?> descripcion;
  final Value<int?> viajeId;
  final Value<int?> vehiculoId;
  final Value<String?> comprobantePath;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  const EgresosCompanion({
    this.id = const Value.absent(),
    this.monto = const Value.absent(),
    this.fecha = const Value.absent(),
    this.categoria = const Value.absent(),
    this.descripcion = const Value.absent(),
    this.viajeId = const Value.absent(),
    this.vehiculoId = const Value.absent(),
    this.comprobantePath = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  EgresosCompanion.insert({
    this.id = const Value.absent(),
    required double monto,
    required DateTime fecha,
    required EgresoCategoria categoria,
    this.descripcion = const Value.absent(),
    this.viajeId = const Value.absent(),
    this.vehiculoId = const Value.absent(),
    this.comprobantePath = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  }) : monto = Value(monto),
       fecha = Value(fecha),
       categoria = Value(categoria);
  static Insertable<Egreso> custom({
    Expression<int>? id,
    Expression<double>? monto,
    Expression<DateTime>? fecha,
    Expression<int>? categoria,
    Expression<String>? descripcion,
    Expression<int>? viajeId,
    Expression<int>? vehiculoId,
    Expression<String>? comprobantePath,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (monto != null) 'monto': monto,
      if (fecha != null) 'fecha': fecha,
      if (categoria != null) 'categoria': categoria,
      if (descripcion != null) 'descripcion': descripcion,
      if (viajeId != null) 'viaje_id': viajeId,
      if (vehiculoId != null) 'vehiculo_id': vehiculoId,
      if (comprobantePath != null) 'comprobante_path': comprobantePath,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  EgresosCompanion copyWith({
    Value<int>? id,
    Value<double>? monto,
    Value<DateTime>? fecha,
    Value<EgresoCategoria>? categoria,
    Value<String?>? descripcion,
    Value<int?>? viajeId,
    Value<int?>? vehiculoId,
    Value<String?>? comprobantePath,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
  }) {
    return EgresosCompanion(
      id: id ?? this.id,
      monto: monto ?? this.monto,
      fecha: fecha ?? this.fecha,
      categoria: categoria ?? this.categoria,
      descripcion: descripcion ?? this.descripcion,
      viajeId: viajeId ?? this.viajeId,
      vehiculoId: vehiculoId ?? this.vehiculoId,
      comprobantePath: comprobantePath ?? this.comprobantePath,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (monto.present) {
      map['monto'] = Variable<double>(monto.value);
    }
    if (fecha.present) {
      map['fecha'] = Variable<DateTime>(fecha.value);
    }
    if (categoria.present) {
      map['categoria'] = Variable<int>(
        $EgresosTable.$convertercategoria.toSql(categoria.value),
      );
    }
    if (descripcion.present) {
      map['descripcion'] = Variable<String>(descripcion.value);
    }
    if (viajeId.present) {
      map['viaje_id'] = Variable<int>(viajeId.value);
    }
    if (vehiculoId.present) {
      map['vehiculo_id'] = Variable<int>(vehiculoId.value);
    }
    if (comprobantePath.present) {
      map['comprobante_path'] = Variable<String>(comprobantePath.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('EgresosCompanion(')
          ..write('id: $id, ')
          ..write('monto: $monto, ')
          ..write('fecha: $fecha, ')
          ..write('categoria: $categoria, ')
          ..write('descripcion: $descripcion, ')
          ..write('viajeId: $viajeId, ')
          ..write('vehiculoId: $vehiculoId, ')
          ..write('comprobantePath: $comprobantePath, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

class $ImpuestosTable extends Impuestos
    with TableInfo<$ImpuestosTable, Impuesto> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ImpuestosTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _tipoMeta = const VerificationMeta('tipo');
  @override
  late final GeneratedColumn<String> tipo = GeneratedColumn<String>(
    'tipo',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _periodoMeta = const VerificationMeta(
    'periodo',
  );
  @override
  late final GeneratedColumn<String> periodo = GeneratedColumn<String>(
    'periodo',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _montoMeta = const VerificationMeta('monto');
  @override
  late final GeneratedColumn<double> monto = GeneratedColumn<double>(
    'monto',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _fechaVencimientoMeta = const VerificationMeta(
    'fechaVencimiento',
  );
  @override
  late final GeneratedColumn<DateTime> fechaVencimiento =
      GeneratedColumn<DateTime>(
        'fecha_vencimiento',
        aliasedName,
        false,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: true,
      );
  static const VerificationMeta _fechaPagoMeta = const VerificationMeta(
    'fechaPago',
  );
  @override
  late final GeneratedColumn<DateTime> fechaPago = GeneratedColumn<DateTime>(
    'fecha_pago',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  @override
  late final GeneratedColumnWithTypeConverter<ImpuestoEstado, int> estado =
      GeneratedColumn<int>(
        'estado',
        aliasedName,
        false,
        type: DriftSqlType.int,
        requiredDuringInsert: false,
        defaultValue: Constant(ImpuestoEstado.pendiente.index),
      ).withConverter<ImpuestoEstado>($ImpuestosTable.$converterestado);
  static const VerificationMeta _comprobantePathMeta = const VerificationMeta(
    'comprobantePath',
  );
  @override
  late final GeneratedColumn<String> comprobantePath = GeneratedColumn<String>(
    'comprobante_path',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    tipo,
    periodo,
    monto,
    fechaVencimiento,
    fechaPago,
    estado,
    comprobantePath,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'impuestos';
  @override
  VerificationContext validateIntegrity(
    Insertable<Impuesto> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('tipo')) {
      context.handle(
        _tipoMeta,
        tipo.isAcceptableOrUnknown(data['tipo']!, _tipoMeta),
      );
    } else if (isInserting) {
      context.missing(_tipoMeta);
    }
    if (data.containsKey('periodo')) {
      context.handle(
        _periodoMeta,
        periodo.isAcceptableOrUnknown(data['periodo']!, _periodoMeta),
      );
    } else if (isInserting) {
      context.missing(_periodoMeta);
    }
    if (data.containsKey('monto')) {
      context.handle(
        _montoMeta,
        monto.isAcceptableOrUnknown(data['monto']!, _montoMeta),
      );
    } else if (isInserting) {
      context.missing(_montoMeta);
    }
    if (data.containsKey('fecha_vencimiento')) {
      context.handle(
        _fechaVencimientoMeta,
        fechaVencimiento.isAcceptableOrUnknown(
          data['fecha_vencimiento']!,
          _fechaVencimientoMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_fechaVencimientoMeta);
    }
    if (data.containsKey('fecha_pago')) {
      context.handle(
        _fechaPagoMeta,
        fechaPago.isAcceptableOrUnknown(data['fecha_pago']!, _fechaPagoMeta),
      );
    }
    if (data.containsKey('comprobante_path')) {
      context.handle(
        _comprobantePathMeta,
        comprobantePath.isAcceptableOrUnknown(
          data['comprobante_path']!,
          _comprobantePathMeta,
        ),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Impuesto map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Impuesto(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      tipo: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}tipo'],
      )!,
      periodo: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}periodo'],
      )!,
      monto: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}monto'],
      )!,
      fechaVencimiento: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}fecha_vencimiento'],
      )!,
      fechaPago: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}fecha_pago'],
      ),
      estado: $ImpuestosTable.$converterestado.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.int,
          data['${effectivePrefix}estado'],
        )!,
      ),
      comprobantePath: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}comprobante_path'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $ImpuestosTable createAlias(String alias) {
    return $ImpuestosTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<ImpuestoEstado, int, int> $converterestado =
      const EnumIndexConverter<ImpuestoEstado>(ImpuestoEstado.values);
}

class Impuesto extends DataClass implements Insertable<Impuesto> {
  final int id;
  final String tipo;
  final String periodo;
  final double monto;
  final DateTime fechaVencimiento;
  final DateTime? fechaPago;
  final ImpuestoEstado estado;
  final String? comprobantePath;
  final DateTime createdAt;
  final DateTime updatedAt;
  const Impuesto({
    required this.id,
    required this.tipo,
    required this.periodo,
    required this.monto,
    required this.fechaVencimiento,
    this.fechaPago,
    required this.estado,
    this.comprobantePath,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['tipo'] = Variable<String>(tipo);
    map['periodo'] = Variable<String>(periodo);
    map['monto'] = Variable<double>(monto);
    map['fecha_vencimiento'] = Variable<DateTime>(fechaVencimiento);
    if (!nullToAbsent || fechaPago != null) {
      map['fecha_pago'] = Variable<DateTime>(fechaPago);
    }
    {
      map['estado'] = Variable<int>(
        $ImpuestosTable.$converterestado.toSql(estado),
      );
    }
    if (!nullToAbsent || comprobantePath != null) {
      map['comprobante_path'] = Variable<String>(comprobantePath);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  ImpuestosCompanion toCompanion(bool nullToAbsent) {
    return ImpuestosCompanion(
      id: Value(id),
      tipo: Value(tipo),
      periodo: Value(periodo),
      monto: Value(monto),
      fechaVencimiento: Value(fechaVencimiento),
      fechaPago: fechaPago == null && nullToAbsent
          ? const Value.absent()
          : Value(fechaPago),
      estado: Value(estado),
      comprobantePath: comprobantePath == null && nullToAbsent
          ? const Value.absent()
          : Value(comprobantePath),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory Impuesto.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Impuesto(
      id: serializer.fromJson<int>(json['id']),
      tipo: serializer.fromJson<String>(json['tipo']),
      periodo: serializer.fromJson<String>(json['periodo']),
      monto: serializer.fromJson<double>(json['monto']),
      fechaVencimiento: serializer.fromJson<DateTime>(json['fechaVencimiento']),
      fechaPago: serializer.fromJson<DateTime?>(json['fechaPago']),
      estado: $ImpuestosTable.$converterestado.fromJson(
        serializer.fromJson<int>(json['estado']),
      ),
      comprobantePath: serializer.fromJson<String?>(json['comprobantePath']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'tipo': serializer.toJson<String>(tipo),
      'periodo': serializer.toJson<String>(periodo),
      'monto': serializer.toJson<double>(monto),
      'fechaVencimiento': serializer.toJson<DateTime>(fechaVencimiento),
      'fechaPago': serializer.toJson<DateTime?>(fechaPago),
      'estado': serializer.toJson<int>(
        $ImpuestosTable.$converterestado.toJson(estado),
      ),
      'comprobantePath': serializer.toJson<String?>(comprobantePath),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  Impuesto copyWith({
    int? id,
    String? tipo,
    String? periodo,
    double? monto,
    DateTime? fechaVencimiento,
    Value<DateTime?> fechaPago = const Value.absent(),
    ImpuestoEstado? estado,
    Value<String?> comprobantePath = const Value.absent(),
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => Impuesto(
    id: id ?? this.id,
    tipo: tipo ?? this.tipo,
    periodo: periodo ?? this.periodo,
    monto: monto ?? this.monto,
    fechaVencimiento: fechaVencimiento ?? this.fechaVencimiento,
    fechaPago: fechaPago.present ? fechaPago.value : this.fechaPago,
    estado: estado ?? this.estado,
    comprobantePath: comprobantePath.present
        ? comprobantePath.value
        : this.comprobantePath,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  Impuesto copyWithCompanion(ImpuestosCompanion data) {
    return Impuesto(
      id: data.id.present ? data.id.value : this.id,
      tipo: data.tipo.present ? data.tipo.value : this.tipo,
      periodo: data.periodo.present ? data.periodo.value : this.periodo,
      monto: data.monto.present ? data.monto.value : this.monto,
      fechaVencimiento: data.fechaVencimiento.present
          ? data.fechaVencimiento.value
          : this.fechaVencimiento,
      fechaPago: data.fechaPago.present ? data.fechaPago.value : this.fechaPago,
      estado: data.estado.present ? data.estado.value : this.estado,
      comprobantePath: data.comprobantePath.present
          ? data.comprobantePath.value
          : this.comprobantePath,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Impuesto(')
          ..write('id: $id, ')
          ..write('tipo: $tipo, ')
          ..write('periodo: $periodo, ')
          ..write('monto: $monto, ')
          ..write('fechaVencimiento: $fechaVencimiento, ')
          ..write('fechaPago: $fechaPago, ')
          ..write('estado: $estado, ')
          ..write('comprobantePath: $comprobantePath, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    tipo,
    periodo,
    monto,
    fechaVencimiento,
    fechaPago,
    estado,
    comprobantePath,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Impuesto &&
          other.id == this.id &&
          other.tipo == this.tipo &&
          other.periodo == this.periodo &&
          other.monto == this.monto &&
          other.fechaVencimiento == this.fechaVencimiento &&
          other.fechaPago == this.fechaPago &&
          other.estado == this.estado &&
          other.comprobantePath == this.comprobantePath &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class ImpuestosCompanion extends UpdateCompanion<Impuesto> {
  final Value<int> id;
  final Value<String> tipo;
  final Value<String> periodo;
  final Value<double> monto;
  final Value<DateTime> fechaVencimiento;
  final Value<DateTime?> fechaPago;
  final Value<ImpuestoEstado> estado;
  final Value<String?> comprobantePath;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  const ImpuestosCompanion({
    this.id = const Value.absent(),
    this.tipo = const Value.absent(),
    this.periodo = const Value.absent(),
    this.monto = const Value.absent(),
    this.fechaVencimiento = const Value.absent(),
    this.fechaPago = const Value.absent(),
    this.estado = const Value.absent(),
    this.comprobantePath = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  ImpuestosCompanion.insert({
    this.id = const Value.absent(),
    required String tipo,
    required String periodo,
    required double monto,
    required DateTime fechaVencimiento,
    this.fechaPago = const Value.absent(),
    this.estado = const Value.absent(),
    this.comprobantePath = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  }) : tipo = Value(tipo),
       periodo = Value(periodo),
       monto = Value(monto),
       fechaVencimiento = Value(fechaVencimiento);
  static Insertable<Impuesto> custom({
    Expression<int>? id,
    Expression<String>? tipo,
    Expression<String>? periodo,
    Expression<double>? monto,
    Expression<DateTime>? fechaVencimiento,
    Expression<DateTime>? fechaPago,
    Expression<int>? estado,
    Expression<String>? comprobantePath,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (tipo != null) 'tipo': tipo,
      if (periodo != null) 'periodo': periodo,
      if (monto != null) 'monto': monto,
      if (fechaVencimiento != null) 'fecha_vencimiento': fechaVencimiento,
      if (fechaPago != null) 'fecha_pago': fechaPago,
      if (estado != null) 'estado': estado,
      if (comprobantePath != null) 'comprobante_path': comprobantePath,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  ImpuestosCompanion copyWith({
    Value<int>? id,
    Value<String>? tipo,
    Value<String>? periodo,
    Value<double>? monto,
    Value<DateTime>? fechaVencimiento,
    Value<DateTime?>? fechaPago,
    Value<ImpuestoEstado>? estado,
    Value<String?>? comprobantePath,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
  }) {
    return ImpuestosCompanion(
      id: id ?? this.id,
      tipo: tipo ?? this.tipo,
      periodo: periodo ?? this.periodo,
      monto: monto ?? this.monto,
      fechaVencimiento: fechaVencimiento ?? this.fechaVencimiento,
      fechaPago: fechaPago ?? this.fechaPago,
      estado: estado ?? this.estado,
      comprobantePath: comprobantePath ?? this.comprobantePath,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (tipo.present) {
      map['tipo'] = Variable<String>(tipo.value);
    }
    if (periodo.present) {
      map['periodo'] = Variable<String>(periodo.value);
    }
    if (monto.present) {
      map['monto'] = Variable<double>(monto.value);
    }
    if (fechaVencimiento.present) {
      map['fecha_vencimiento'] = Variable<DateTime>(fechaVencimiento.value);
    }
    if (fechaPago.present) {
      map['fecha_pago'] = Variable<DateTime>(fechaPago.value);
    }
    if (estado.present) {
      map['estado'] = Variable<int>(
        $ImpuestosTable.$converterestado.toSql(estado.value),
      );
    }
    if (comprobantePath.present) {
      map['comprobante_path'] = Variable<String>(comprobantePath.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ImpuestosCompanion(')
          ..write('id: $id, ')
          ..write('tipo: $tipo, ')
          ..write('periodo: $periodo, ')
          ..write('monto: $monto, ')
          ..write('fechaVencimiento: $fechaVencimiento, ')
          ..write('fechaPago: $fechaPago, ')
          ..write('estado: $estado, ')
          ..write('comprobantePath: $comprobantePath, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $TrabajadoresTable trabajadores = $TrabajadoresTable(this);
  late final $VehiculosTable vehiculos = $VehiculosTable(this);
  late final $ViajesTable viajes = $ViajesTable(this);
  late final $IngresosTable ingresos = $IngresosTable(this);
  late final $EgresosTable egresos = $EgresosTable(this);
  late final $ImpuestosTable impuestos = $ImpuestosTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    trabajadores,
    vehiculos,
    viajes,
    ingresos,
    egresos,
    impuestos,
  ];
}

typedef $$TrabajadoresTableCreateCompanionBuilder =
    TrabajadoresCompanion Function({
      Value<int> id,
      required String nombre,
      required String dni,
      Value<String?> telefono,
      Value<String> cargo,
      Value<DateTime?> fechaIngreso,
      Value<bool> activo,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
    });
typedef $$TrabajadoresTableUpdateCompanionBuilder =
    TrabajadoresCompanion Function({
      Value<int> id,
      Value<String> nombre,
      Value<String> dni,
      Value<String?> telefono,
      Value<String> cargo,
      Value<DateTime?> fechaIngreso,
      Value<bool> activo,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
    });

final class $$TrabajadoresTableReferences
    extends BaseReferences<_$AppDatabase, $TrabajadoresTable, Trabajadore> {
  $$TrabajadoresTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$ViajesTable, List<Viaje>> _viajesRefsTable(
    _$AppDatabase db,
  ) => MultiTypedResultKey.fromTable(
    db.viajes,
    aliasName: 'trabajadores__id__viajes__trabajador_id',
  );

  $$ViajesTableProcessedTableManager get viajesRefs {
    final manager = $$ViajesTableTableManager(
      $_db,
      $_db.viajes,
    ).filter((f) => f.trabajadorId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_viajesRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$TrabajadoresTableFilterComposer
    extends Composer<_$AppDatabase, $TrabajadoresTable> {
  $$TrabajadoresTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get nombre => $composableBuilder(
    column: $table.nombre,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get dni => $composableBuilder(
    column: $table.dni,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get telefono => $composableBuilder(
    column: $table.telefono,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get cargo => $composableBuilder(
    column: $table.cargo,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get fechaIngreso => $composableBuilder(
    column: $table.fechaIngreso,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get activo => $composableBuilder(
    column: $table.activo,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> viajesRefs(
    Expression<bool> Function($$ViajesTableFilterComposer f) f,
  ) {
    final $$ViajesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.viajes,
      getReferencedColumn: (t) => t.trabajadorId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ViajesTableFilterComposer(
            $db: $db,
            $table: $db.viajes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$TrabajadoresTableOrderingComposer
    extends Composer<_$AppDatabase, $TrabajadoresTable> {
  $$TrabajadoresTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get nombre => $composableBuilder(
    column: $table.nombre,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get dni => $composableBuilder(
    column: $table.dni,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get telefono => $composableBuilder(
    column: $table.telefono,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get cargo => $composableBuilder(
    column: $table.cargo,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get fechaIngreso => $composableBuilder(
    column: $table.fechaIngreso,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get activo => $composableBuilder(
    column: $table.activo,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$TrabajadoresTableAnnotationComposer
    extends Composer<_$AppDatabase, $TrabajadoresTable> {
  $$TrabajadoresTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get nombre =>
      $composableBuilder(column: $table.nombre, builder: (column) => column);

  GeneratedColumn<String> get dni =>
      $composableBuilder(column: $table.dni, builder: (column) => column);

  GeneratedColumn<String> get telefono =>
      $composableBuilder(column: $table.telefono, builder: (column) => column);

  GeneratedColumn<String> get cargo =>
      $composableBuilder(column: $table.cargo, builder: (column) => column);

  GeneratedColumn<DateTime> get fechaIngreso => $composableBuilder(
    column: $table.fechaIngreso,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get activo =>
      $composableBuilder(column: $table.activo, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  Expression<T> viajesRefs<T extends Object>(
    Expression<T> Function($$ViajesTableAnnotationComposer a) f,
  ) {
    final $$ViajesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.viajes,
      getReferencedColumn: (t) => t.trabajadorId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ViajesTableAnnotationComposer(
            $db: $db,
            $table: $db.viajes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$TrabajadoresTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $TrabajadoresTable,
          Trabajadore,
          $$TrabajadoresTableFilterComposer,
          $$TrabajadoresTableOrderingComposer,
          $$TrabajadoresTableAnnotationComposer,
          $$TrabajadoresTableCreateCompanionBuilder,
          $$TrabajadoresTableUpdateCompanionBuilder,
          (Trabajadore, $$TrabajadoresTableReferences),
          Trabajadore,
          PrefetchHooks Function({bool viajesRefs})
        > {
  $$TrabajadoresTableTableManager(_$AppDatabase db, $TrabajadoresTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$TrabajadoresTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$TrabajadoresTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$TrabajadoresTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> nombre = const Value.absent(),
                Value<String> dni = const Value.absent(),
                Value<String?> telefono = const Value.absent(),
                Value<String> cargo = const Value.absent(),
                Value<DateTime?> fechaIngreso = const Value.absent(),
                Value<bool> activo = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => TrabajadoresCompanion(
                id: id,
                nombre: nombre,
                dni: dni,
                telefono: telefono,
                cargo: cargo,
                fechaIngreso: fechaIngreso,
                activo: activo,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String nombre,
                required String dni,
                Value<String?> telefono = const Value.absent(),
                Value<String> cargo = const Value.absent(),
                Value<DateTime?> fechaIngreso = const Value.absent(),
                Value<bool> activo = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => TrabajadoresCompanion.insert(
                id: id,
                nombre: nombre,
                dni: dni,
                telefono: telefono,
                cargo: cargo,
                fechaIngreso: fechaIngreso,
                activo: activo,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$TrabajadoresTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({viajesRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (viajesRefs) db.viajes],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (viajesRefs)
                    await $_getPrefetchedData<
                      Trabajadore,
                      $TrabajadoresTable,
                      Viaje
                    >(
                      currentTable: table,
                      referencedTable: $$TrabajadoresTableReferences
                          ._viajesRefsTable(db),
                      managerFromTypedResult: (p0) =>
                          $$TrabajadoresTableReferences(
                            db,
                            table,
                            p0,
                          ).viajesRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) =>
                          referencedItems.where(
                            (e) => e.trabajadorId == item.id,
                          ),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$TrabajadoresTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $TrabajadoresTable,
      Trabajadore,
      $$TrabajadoresTableFilterComposer,
      $$TrabajadoresTableOrderingComposer,
      $$TrabajadoresTableAnnotationComposer,
      $$TrabajadoresTableCreateCompanionBuilder,
      $$TrabajadoresTableUpdateCompanionBuilder,
      (Trabajadore, $$TrabajadoresTableReferences),
      Trabajadore,
      PrefetchHooks Function({bool viajesRefs})
    >;
typedef $$VehiculosTableCreateCompanionBuilder = VehiculosCompanion Function({
  Value<int> id,
  required String placa,
  required String tipo,
  Value<String?> marca,
  Value<String?> modelo,
  Value<int?> anio,
  Value<DateTime?> soatVencimiento,
  Value<DateTime?> revisionTecnicaVencimiento,
  Value<VehiculoEstado> estado,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
});
typedef $$VehiculosTableUpdateCompanionBuilder = VehiculosCompanion Function({
  Value<int> id,
  Value<String> placa,
  Value<String> tipo,
  Value<String?> marca,
  Value<String?> modelo,
  Value<int?> anio,
  Value<DateTime?> soatVencimiento,
  Value<DateTime?> revisionTecnicaVencimiento,
  Value<VehiculoEstado> estado,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
});

final class $$VehiculosTableReferences
    extends BaseReferences<_$AppDatabase, $VehiculosTable, Vehiculo> {
  $$VehiculosTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$ViajesTable, List<Viaje>> _viajesRefsTable(
    _$AppDatabase db,
  ) => MultiTypedResultKey.fromTable(
    db.viajes,
    aliasName: 'vehiculos__id__viajes__vehiculo_id',
  );

  $$ViajesTableProcessedTableManager get viajesRefs {
    final manager = $$ViajesTableTableManager(
      $_db,
      $_db.viajes,
    ).filter((f) => f.vehiculoId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_viajesRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$EgresosTable, List<Egreso>> _egresosRefsTable(
    _$AppDatabase db,
  ) => MultiTypedResultKey.fromTable(
    db.egresos,
    aliasName: 'vehiculos__id__egresos__vehiculo_id',
  );

  $$EgresosTableProcessedTableManager get egresosRefs {
    final manager = $$EgresosTableTableManager(
      $_db,
      $_db.egresos,
    ).filter((f) => f.vehiculoId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_egresosRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$VehiculosTableFilterComposer
    extends Composer<_$AppDatabase, $VehiculosTable> {
  $$VehiculosTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get placa => $composableBuilder(
    column: $table.placa,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get tipo => $composableBuilder(
    column: $table.tipo,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get marca => $composableBuilder(
    column: $table.marca,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get modelo => $composableBuilder(
    column: $table.modelo,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get anio => $composableBuilder(
    column: $table.anio,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get soatVencimiento => $composableBuilder(
    column: $table.soatVencimiento,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get revisionTecnicaVencimiento => $composableBuilder(
    column: $table.revisionTecnicaVencimiento,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<VehiculoEstado, VehiculoEstado, int>
  get estado => $composableBuilder(
    column: $table.estado,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> viajesRefs(
    Expression<bool> Function($$ViajesTableFilterComposer f) f,
  ) {
    final $$ViajesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.viajes,
      getReferencedColumn: (t) => t.vehiculoId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ViajesTableFilterComposer(
            $db: $db,
            $table: $db.viajes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> egresosRefs(
    Expression<bool> Function($$EgresosTableFilterComposer f) f,
  ) {
    final $$EgresosTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.egresos,
      getReferencedColumn: (t) => t.vehiculoId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$EgresosTableFilterComposer(
            $db: $db,
            $table: $db.egresos,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$VehiculosTableOrderingComposer
    extends Composer<_$AppDatabase, $VehiculosTable> {
  $$VehiculosTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get placa => $composableBuilder(
    column: $table.placa,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get tipo => $composableBuilder(
    column: $table.tipo,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get marca => $composableBuilder(
    column: $table.marca,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get modelo => $composableBuilder(
    column: $table.modelo,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get anio => $composableBuilder(
    column: $table.anio,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get soatVencimiento => $composableBuilder(
    column: $table.soatVencimiento,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get revisionTecnicaVencimiento =>
      $composableBuilder(
        column: $table.revisionTecnicaVencimiento,
        builder: (column) => ColumnOrderings(column),
      );

  ColumnOrderings<int> get estado => $composableBuilder(
    column: $table.estado,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$VehiculosTableAnnotationComposer
    extends Composer<_$AppDatabase, $VehiculosTable> {
  $$VehiculosTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get placa =>
      $composableBuilder(column: $table.placa, builder: (column) => column);

  GeneratedColumn<String> get tipo =>
      $composableBuilder(column: $table.tipo, builder: (column) => column);

  GeneratedColumn<String> get marca =>
      $composableBuilder(column: $table.marca, builder: (column) => column);

  GeneratedColumn<String> get modelo =>
      $composableBuilder(column: $table.modelo, builder: (column) => column);

  GeneratedColumn<int> get anio =>
      $composableBuilder(column: $table.anio, builder: (column) => column);

  GeneratedColumn<DateTime> get soatVencimiento => $composableBuilder(
    column: $table.soatVencimiento,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get revisionTecnicaVencimiento =>
      $composableBuilder(
        column: $table.revisionTecnicaVencimiento,
        builder: (column) => column,
      );

  GeneratedColumnWithTypeConverter<VehiculoEstado, int> get estado =>
      $composableBuilder(column: $table.estado, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  Expression<T> viajesRefs<T extends Object>(
    Expression<T> Function($$ViajesTableAnnotationComposer a) f,
  ) {
    final $$ViajesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.viajes,
      getReferencedColumn: (t) => t.vehiculoId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ViajesTableAnnotationComposer(
            $db: $db,
            $table: $db.viajes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> egresosRefs<T extends Object>(
    Expression<T> Function($$EgresosTableAnnotationComposer a) f,
  ) {
    final $$EgresosTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.egresos,
      getReferencedColumn: (t) => t.vehiculoId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$EgresosTableAnnotationComposer(
            $db: $db,
            $table: $db.egresos,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$VehiculosTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $VehiculosTable,
          Vehiculo,
          $$VehiculosTableFilterComposer,
          $$VehiculosTableOrderingComposer,
          $$VehiculosTableAnnotationComposer,
          $$VehiculosTableCreateCompanionBuilder,
          $$VehiculosTableUpdateCompanionBuilder,
          (Vehiculo, $$VehiculosTableReferences),
          Vehiculo,
          PrefetchHooks Function({bool viajesRefs, bool egresosRefs})
        > {
  $$VehiculosTableTableManager(_$AppDatabase db, $VehiculosTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$VehiculosTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$VehiculosTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$VehiculosTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> placa = const Value.absent(),
                Value<String> tipo = const Value.absent(),
                Value<String?> marca = const Value.absent(),
                Value<String?> modelo = const Value.absent(),
                Value<int?> anio = const Value.absent(),
                Value<DateTime?> soatVencimiento = const Value.absent(),
                Value<DateTime?> revisionTecnicaVencimiento =
                    const Value.absent(),
                Value<VehiculoEstado> estado = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => VehiculosCompanion(
                id: id,
                placa: placa,
                tipo: tipo,
                marca: marca,
                modelo: modelo,
                anio: anio,
                soatVencimiento: soatVencimiento,
                revisionTecnicaVencimiento: revisionTecnicaVencimiento,
                estado: estado,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String placa,
                required String tipo,
                Value<String?> marca = const Value.absent(),
                Value<String?> modelo = const Value.absent(),
                Value<int?> anio = const Value.absent(),
                Value<DateTime?> soatVencimiento = const Value.absent(),
                Value<DateTime?> revisionTecnicaVencimiento =
                    const Value.absent(),
                Value<VehiculoEstado> estado = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => VehiculosCompanion.insert(
                id: id,
                placa: placa,
                tipo: tipo,
                marca: marca,
                modelo: modelo,
                anio: anio,
                soatVencimiento: soatVencimiento,
                revisionTecnicaVencimiento: revisionTecnicaVencimiento,
                estado: estado,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$VehiculosTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({viajesRefs = false, egresosRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (viajesRefs) db.viajes,
                if (egresosRefs) db.egresos,
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (viajesRefs)
                    await $_getPrefetchedData<Vehiculo, $VehiculosTable, Viaje>(
                      currentTable: table,
                      referencedTable: $$VehiculosTableReferences
                          ._viajesRefsTable(db),
                      managerFromTypedResult: (p0) =>
                          $$VehiculosTableReferences(db, table, p0).viajesRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) =>
                          referencedItems.where((e) => e.vehiculoId == item.id),
                      typedResults: items,
                    ),
                  if (egresosRefs)
                    await $_getPrefetchedData<
                      Vehiculo,
                      $VehiculosTable,
                      Egreso
                    >(
                      currentTable: table,
                      referencedTable: $$VehiculosTableReferences
                          ._egresosRefsTable(db),
                      managerFromTypedResult: (p0) =>
                          $$VehiculosTableReferences(db, table, p0).egresosRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) =>
                          referencedItems.where((e) => e.vehiculoId == item.id),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$VehiculosTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $VehiculosTable,
      Vehiculo,
      $$VehiculosTableFilterComposer,
      $$VehiculosTableOrderingComposer,
      $$VehiculosTableAnnotationComposer,
      $$VehiculosTableCreateCompanionBuilder,
      $$VehiculosTableUpdateCompanionBuilder,
      (Vehiculo, $$VehiculosTableReferences),
      Vehiculo,
      PrefetchHooks Function({bool viajesRefs, bool egresosRefs})
    >;
typedef $$ViajesTableCreateCompanionBuilder = ViajesCompanion Function({
  Value<int> id,
  required DateTime fechaSalida,
  Value<DateTime?> fechaLlegada,
  required String origen,
  required String destino,
  Value<String> cliente,
  Value<String?> carga,
  Value<double?> kilometraje,
  required int trabajadorId,
  required int vehiculoId,
  Value<ViajeEstado> estado,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
});
typedef $$ViajesTableUpdateCompanionBuilder = ViajesCompanion Function({
  Value<int> id,
  Value<DateTime> fechaSalida,
  Value<DateTime?> fechaLlegada,
  Value<String> origen,
  Value<String> destino,
  Value<String> cliente,
  Value<String?> carga,
  Value<double?> kilometraje,
  Value<int> trabajadorId,
  Value<int> vehiculoId,
  Value<ViajeEstado> estado,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
});

final class $$ViajesTableReferences
    extends BaseReferences<_$AppDatabase, $ViajesTable, Viaje> {
  $$ViajesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $TrabajadoresTable _trabajadorIdTable(_$AppDatabase db) =>
      db.trabajadores.createAlias('viajes__trabajador_id__trabajadores__id');

  $$TrabajadoresTableProcessedTableManager get trabajadorId {
    final $_column = $_itemColumn<int>('trabajador_id')!;

    final manager = $$TrabajadoresTableTableManager(
      $_db,
      $_db.trabajadores,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_trabajadorIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $VehiculosTable _vehiculoIdTable(_$AppDatabase db) =>
      db.vehiculos.createAlias('viajes__vehiculo_id__vehiculos__id');

  $$VehiculosTableProcessedTableManager get vehiculoId {
    final $_column = $_itemColumn<int>('vehiculo_id')!;

    final manager = $$VehiculosTableTableManager(
      $_db,
      $_db.vehiculos,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_vehiculoIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<$IngresosTable, List<Ingreso>> _ingresosRefsTable(
    _$AppDatabase db,
  ) => MultiTypedResultKey.fromTable(
    db.ingresos,
    aliasName: 'viajes__id__ingresos__viaje_id',
  );

  $$IngresosTableProcessedTableManager get ingresosRefs {
    final manager = $$IngresosTableTableManager(
      $_db,
      $_db.ingresos,
    ).filter((f) => f.viajeId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_ingresosRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$EgresosTable, List<Egreso>> _egresosRefsTable(
    _$AppDatabase db,
  ) => MultiTypedResultKey.fromTable(
    db.egresos,
    aliasName: 'viajes__id__egresos__viaje_id',
  );

  $$EgresosTableProcessedTableManager get egresosRefs {
    final manager = $$EgresosTableTableManager(
      $_db,
      $_db.egresos,
    ).filter((f) => f.viajeId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_egresosRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$ViajesTableFilterComposer
    extends Composer<_$AppDatabase, $ViajesTable> {
  $$ViajesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get fechaSalida => $composableBuilder(
    column: $table.fechaSalida,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get fechaLlegada => $composableBuilder(
    column: $table.fechaLlegada,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get origen => $composableBuilder(
    column: $table.origen,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get destino => $composableBuilder(
    column: $table.destino,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get cliente => $composableBuilder(
    column: $table.cliente,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get carga => $composableBuilder(
    column: $table.carga,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get kilometraje => $composableBuilder(
    column: $table.kilometraje,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<ViajeEstado, ViajeEstado, int> get estado =>
      $composableBuilder(
        column: $table.estado,
        builder: (column) => ColumnWithTypeConverterFilters(column),
      );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  $$TrabajadoresTableFilterComposer get trabajadorId {
    final $$TrabajadoresTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.trabajadorId,
      referencedTable: $db.trabajadores,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TrabajadoresTableFilterComposer(
            $db: $db,
            $table: $db.trabajadores,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$VehiculosTableFilterComposer get vehiculoId {
    final $$VehiculosTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.vehiculoId,
      referencedTable: $db.vehiculos,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$VehiculosTableFilterComposer(
            $db: $db,
            $table: $db.vehiculos,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> ingresosRefs(
    Expression<bool> Function($$IngresosTableFilterComposer f) f,
  ) {
    final $$IngresosTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.ingresos,
      getReferencedColumn: (t) => t.viajeId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$IngresosTableFilterComposer(
            $db: $db,
            $table: $db.ingresos,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> egresosRefs(
    Expression<bool> Function($$EgresosTableFilterComposer f) f,
  ) {
    final $$EgresosTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.egresos,
      getReferencedColumn: (t) => t.viajeId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$EgresosTableFilterComposer(
            $db: $db,
            $table: $db.egresos,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$ViajesTableOrderingComposer
    extends Composer<_$AppDatabase, $ViajesTable> {
  $$ViajesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get fechaSalida => $composableBuilder(
    column: $table.fechaSalida,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get fechaLlegada => $composableBuilder(
    column: $table.fechaLlegada,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get origen => $composableBuilder(
    column: $table.origen,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get destino => $composableBuilder(
    column: $table.destino,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get cliente => $composableBuilder(
    column: $table.cliente,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get carga => $composableBuilder(
    column: $table.carga,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get kilometraje => $composableBuilder(
    column: $table.kilometraje,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get estado => $composableBuilder(
    column: $table.estado,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$TrabajadoresTableOrderingComposer get trabajadorId {
    final $$TrabajadoresTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.trabajadorId,
      referencedTable: $db.trabajadores,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TrabajadoresTableOrderingComposer(
            $db: $db,
            $table: $db.trabajadores,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$VehiculosTableOrderingComposer get vehiculoId {
    final $$VehiculosTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.vehiculoId,
      referencedTable: $db.vehiculos,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$VehiculosTableOrderingComposer(
            $db: $db,
            $table: $db.vehiculos,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ViajesTableAnnotationComposer
    extends Composer<_$AppDatabase, $ViajesTable> {
  $$ViajesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get fechaSalida => $composableBuilder(
    column: $table.fechaSalida,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get fechaLlegada => $composableBuilder(
    column: $table.fechaLlegada,
    builder: (column) => column,
  );

  GeneratedColumn<String> get origen =>
      $composableBuilder(column: $table.origen, builder: (column) => column);

  GeneratedColumn<String> get destino =>
      $composableBuilder(column: $table.destino, builder: (column) => column);

  GeneratedColumn<String> get cliente =>
      $composableBuilder(column: $table.cliente, builder: (column) => column);

  GeneratedColumn<String> get carga =>
      $composableBuilder(column: $table.carga, builder: (column) => column);

  GeneratedColumn<double> get kilometraje => $composableBuilder(
    column: $table.kilometraje,
    builder: (column) => column,
  );

  GeneratedColumnWithTypeConverter<ViajeEstado, int> get estado =>
      $composableBuilder(column: $table.estado, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  $$TrabajadoresTableAnnotationComposer get trabajadorId {
    final $$TrabajadoresTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.trabajadorId,
      referencedTable: $db.trabajadores,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TrabajadoresTableAnnotationComposer(
            $db: $db,
            $table: $db.trabajadores,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$VehiculosTableAnnotationComposer get vehiculoId {
    final $$VehiculosTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.vehiculoId,
      referencedTable: $db.vehiculos,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$VehiculosTableAnnotationComposer(
            $db: $db,
            $table: $db.vehiculos,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> ingresosRefs<T extends Object>(
    Expression<T> Function($$IngresosTableAnnotationComposer a) f,
  ) {
    final $$IngresosTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.ingresos,
      getReferencedColumn: (t) => t.viajeId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$IngresosTableAnnotationComposer(
            $db: $db,
            $table: $db.ingresos,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> egresosRefs<T extends Object>(
    Expression<T> Function($$EgresosTableAnnotationComposer a) f,
  ) {
    final $$EgresosTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.egresos,
      getReferencedColumn: (t) => t.viajeId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$EgresosTableAnnotationComposer(
            $db: $db,
            $table: $db.egresos,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$ViajesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ViajesTable,
          Viaje,
          $$ViajesTableFilterComposer,
          $$ViajesTableOrderingComposer,
          $$ViajesTableAnnotationComposer,
          $$ViajesTableCreateCompanionBuilder,
          $$ViajesTableUpdateCompanionBuilder,
          (Viaje, $$ViajesTableReferences),
          Viaje,
          PrefetchHooks Function({
            bool trabajadorId,
            bool vehiculoId,
            bool ingresosRefs,
            bool egresosRefs,
          })
        > {
  $$ViajesTableTableManager(_$AppDatabase db, $ViajesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ViajesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ViajesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ViajesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<DateTime> fechaSalida = const Value.absent(),
                Value<DateTime?> fechaLlegada = const Value.absent(),
                Value<String> origen = const Value.absent(),
                Value<String> destino = const Value.absent(),
                Value<String> cliente = const Value.absent(),
                Value<String?> carga = const Value.absent(),
                Value<double?> kilometraje = const Value.absent(),
                Value<int> trabajadorId = const Value.absent(),
                Value<int> vehiculoId = const Value.absent(),
                Value<ViajeEstado> estado = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => ViajesCompanion(
                id: id,
                fechaSalida: fechaSalida,
                fechaLlegada: fechaLlegada,
                origen: origen,
                destino: destino,
                cliente: cliente,
                carga: carga,
                kilometraje: kilometraje,
                trabajadorId: trabajadorId,
                vehiculoId: vehiculoId,
                estado: estado,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required DateTime fechaSalida,
                Value<DateTime?> fechaLlegada = const Value.absent(),
                required String origen,
                required String destino,
                Value<String> cliente = const Value.absent(),
                Value<String?> carga = const Value.absent(),
                Value<double?> kilometraje = const Value.absent(),
                required int trabajadorId,
                required int vehiculoId,
                Value<ViajeEstado> estado = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => ViajesCompanion.insert(
                id: id,
                fechaSalida: fechaSalida,
                fechaLlegada: fechaLlegada,
                origen: origen,
                destino: destino,
                cliente: cliente,
                carga: carga,
                kilometraje: kilometraje,
                trabajadorId: trabajadorId,
                vehiculoId: vehiculoId,
                estado: estado,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) =>
                    (e.readTable(table), $$ViajesTableReferences(db, table, e)),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                trabajadorId = false,
                vehiculoId = false,
                ingresosRefs = false,
                egresosRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (ingresosRefs) db.ingresos,
                    if (egresosRefs) db.egresos,
                  ],
                  addJoins:
                      <
                        T extends TableManagerState<
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic
                        >
                      >(state) {
                        if (trabajadorId) {
                          state = state.withJoin(
                            currentTable: table,
                            currentColumn: table.trabajadorId,
                            referencedTable: $$ViajesTableReferences
                                ._trabajadorIdTable(db),
                            referencedColumn: $$ViajesTableReferences
                                ._trabajadorIdTable(db)
                                .id,
                          ) as T;
                        }
                        if (vehiculoId) {
                          state = state.withJoin(
                            currentTable: table,
                            currentColumn: table.vehiculoId,
                            referencedTable: $$ViajesTableReferences
                                ._vehiculoIdTable(db),
                            referencedColumn: $$ViajesTableReferences
                                ._vehiculoIdTable(db)
                                .id,
                          ) as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (ingresosRefs)
                        await $_getPrefetchedData<Viaje, $ViajesTable, Ingreso>(
                          currentTable: table,
                          referencedTable: $$ViajesTableReferences
                              ._ingresosRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$ViajesTableReferences(
                                db,
                                table,
                                p0,
                              ).ingresosRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.viajeId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (egresosRefs)
                        await $_getPrefetchedData<Viaje, $ViajesTable, Egreso>(
                          currentTable: table,
                          referencedTable: $$ViajesTableReferences
                              ._egresosRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$ViajesTableReferences(
                                db,
                                table,
                                p0,
                              ).egresosRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.viajeId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$ViajesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ViajesTable,
      Viaje,
      $$ViajesTableFilterComposer,
      $$ViajesTableOrderingComposer,
      $$ViajesTableAnnotationComposer,
      $$ViajesTableCreateCompanionBuilder,
      $$ViajesTableUpdateCompanionBuilder,
      (Viaje, $$ViajesTableReferences),
      Viaje,
      PrefetchHooks Function({
        bool trabajadorId,
        bool vehiculoId,
        bool ingresosRefs,
        bool egresosRefs,
      })
    >;
typedef $$IngresosTableCreateCompanionBuilder = IngresosCompanion Function({
  Value<int> id,
  required double monto,
  required DateTime fecha,
  required String concepto,
  Value<int?> viajeId,
  Value<String?> comprobantePath,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
});
typedef $$IngresosTableUpdateCompanionBuilder = IngresosCompanion Function({
  Value<int> id,
  Value<double> monto,
  Value<DateTime> fecha,
  Value<String> concepto,
  Value<int?> viajeId,
  Value<String?> comprobantePath,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
});

final class $$IngresosTableReferences
    extends BaseReferences<_$AppDatabase, $IngresosTable, Ingreso> {
  $$IngresosTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $ViajesTable _viajeIdTable(_$AppDatabase db) =>
      db.viajes.createAlias('ingresos__viaje_id__viajes__id');

  $$ViajesTableProcessedTableManager? get viajeId {
    final $_column = $_itemColumn<int>('viaje_id');
    if ($_column == null) return null;
    final manager = $$ViajesTableTableManager(
      $_db,
      $_db.viajes,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_viajeIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$IngresosTableFilterComposer
    extends Composer<_$AppDatabase, $IngresosTable> {
  $$IngresosTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get monto => $composableBuilder(
    column: $table.monto,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get fecha => $composableBuilder(
    column: $table.fecha,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get concepto => $composableBuilder(
    column: $table.concepto,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get comprobantePath => $composableBuilder(
    column: $table.comprobantePath,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  $$ViajesTableFilterComposer get viajeId {
    final $$ViajesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.viajeId,
      referencedTable: $db.viajes,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ViajesTableFilterComposer(
            $db: $db,
            $table: $db.viajes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$IngresosTableOrderingComposer
    extends Composer<_$AppDatabase, $IngresosTable> {
  $$IngresosTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get monto => $composableBuilder(
    column: $table.monto,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get fecha => $composableBuilder(
    column: $table.fecha,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get concepto => $composableBuilder(
    column: $table.concepto,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get comprobantePath => $composableBuilder(
    column: $table.comprobantePath,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$ViajesTableOrderingComposer get viajeId {
    final $$ViajesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.viajeId,
      referencedTable: $db.viajes,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ViajesTableOrderingComposer(
            $db: $db,
            $table: $db.viajes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$IngresosTableAnnotationComposer
    extends Composer<_$AppDatabase, $IngresosTable> {
  $$IngresosTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<double> get monto =>
      $composableBuilder(column: $table.monto, builder: (column) => column);

  GeneratedColumn<DateTime> get fecha =>
      $composableBuilder(column: $table.fecha, builder: (column) => column);

  GeneratedColumn<String> get concepto =>
      $composableBuilder(column: $table.concepto, builder: (column) => column);

  GeneratedColumn<String> get comprobantePath => $composableBuilder(
    column: $table.comprobantePath,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  $$ViajesTableAnnotationComposer get viajeId {
    final $$ViajesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.viajeId,
      referencedTable: $db.viajes,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ViajesTableAnnotationComposer(
            $db: $db,
            $table: $db.viajes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$IngresosTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $IngresosTable,
          Ingreso,
          $$IngresosTableFilterComposer,
          $$IngresosTableOrderingComposer,
          $$IngresosTableAnnotationComposer,
          $$IngresosTableCreateCompanionBuilder,
          $$IngresosTableUpdateCompanionBuilder,
          (Ingreso, $$IngresosTableReferences),
          Ingreso,
          PrefetchHooks Function({bool viajeId})
        > {
  $$IngresosTableTableManager(_$AppDatabase db, $IngresosTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$IngresosTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$IngresosTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$IngresosTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<double> monto = const Value.absent(),
                Value<DateTime> fecha = const Value.absent(),
                Value<String> concepto = const Value.absent(),
                Value<int?> viajeId = const Value.absent(),
                Value<String?> comprobantePath = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => IngresosCompanion(
                id: id,
                monto: monto,
                fecha: fecha,
                concepto: concepto,
                viajeId: viajeId,
                comprobantePath: comprobantePath,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required double monto,
                required DateTime fecha,
                required String concepto,
                Value<int?> viajeId = const Value.absent(),
                Value<String?> comprobantePath = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => IngresosCompanion.insert(
                id: id,
                monto: monto,
                fecha: fecha,
                concepto: concepto,
                viajeId: viajeId,
                comprobantePath: comprobantePath,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$IngresosTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({viajeId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (viajeId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.viajeId,
                        referencedTable: $$IngresosTableReferences
                            ._viajeIdTable(db),
                        referencedColumn: $$IngresosTableReferences
                            ._viajeIdTable(db)
                            .id,
                      ) as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$IngresosTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $IngresosTable,
      Ingreso,
      $$IngresosTableFilterComposer,
      $$IngresosTableOrderingComposer,
      $$IngresosTableAnnotationComposer,
      $$IngresosTableCreateCompanionBuilder,
      $$IngresosTableUpdateCompanionBuilder,
      (Ingreso, $$IngresosTableReferences),
      Ingreso,
      PrefetchHooks Function({bool viajeId})
    >;
typedef $$EgresosTableCreateCompanionBuilder = EgresosCompanion Function({
  Value<int> id,
  required double monto,
  required DateTime fecha,
  required EgresoCategoria categoria,
  Value<String?> descripcion,
  Value<int?> viajeId,
  Value<int?> vehiculoId,
  Value<String?> comprobantePath,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
});
typedef $$EgresosTableUpdateCompanionBuilder = EgresosCompanion Function({
  Value<int> id,
  Value<double> monto,
  Value<DateTime> fecha,
  Value<EgresoCategoria> categoria,
  Value<String?> descripcion,
  Value<int?> viajeId,
  Value<int?> vehiculoId,
  Value<String?> comprobantePath,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
});

final class $$EgresosTableReferences
    extends BaseReferences<_$AppDatabase, $EgresosTable, Egreso> {
  $$EgresosTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $ViajesTable _viajeIdTable(_$AppDatabase db) =>
      db.viajes.createAlias('egresos__viaje_id__viajes__id');

  $$ViajesTableProcessedTableManager? get viajeId {
    final $_column = $_itemColumn<int>('viaje_id');
    if ($_column == null) return null;
    final manager = $$ViajesTableTableManager(
      $_db,
      $_db.viajes,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_viajeIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $VehiculosTable _vehiculoIdTable(_$AppDatabase db) =>
      db.vehiculos.createAlias('egresos__vehiculo_id__vehiculos__id');

  $$VehiculosTableProcessedTableManager? get vehiculoId {
    final $_column = $_itemColumn<int>('vehiculo_id');
    if ($_column == null) return null;
    final manager = $$VehiculosTableTableManager(
      $_db,
      $_db.vehiculos,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_vehiculoIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$EgresosTableFilterComposer
    extends Composer<_$AppDatabase, $EgresosTable> {
  $$EgresosTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get monto => $composableBuilder(
    column: $table.monto,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get fecha => $composableBuilder(
    column: $table.fecha,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<EgresoCategoria, EgresoCategoria, int>
  get categoria => $composableBuilder(
    column: $table.categoria,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnFilters<String> get descripcion => $composableBuilder(
    column: $table.descripcion,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get comprobantePath => $composableBuilder(
    column: $table.comprobantePath,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  $$ViajesTableFilterComposer get viajeId {
    final $$ViajesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.viajeId,
      referencedTable: $db.viajes,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ViajesTableFilterComposer(
            $db: $db,
            $table: $db.viajes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$VehiculosTableFilterComposer get vehiculoId {
    final $$VehiculosTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.vehiculoId,
      referencedTable: $db.vehiculos,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$VehiculosTableFilterComposer(
            $db: $db,
            $table: $db.vehiculos,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$EgresosTableOrderingComposer
    extends Composer<_$AppDatabase, $EgresosTable> {
  $$EgresosTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get monto => $composableBuilder(
    column: $table.monto,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get fecha => $composableBuilder(
    column: $table.fecha,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get categoria => $composableBuilder(
    column: $table.categoria,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get descripcion => $composableBuilder(
    column: $table.descripcion,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get comprobantePath => $composableBuilder(
    column: $table.comprobantePath,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$ViajesTableOrderingComposer get viajeId {
    final $$ViajesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.viajeId,
      referencedTable: $db.viajes,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ViajesTableOrderingComposer(
            $db: $db,
            $table: $db.viajes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$VehiculosTableOrderingComposer get vehiculoId {
    final $$VehiculosTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.vehiculoId,
      referencedTable: $db.vehiculos,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$VehiculosTableOrderingComposer(
            $db: $db,
            $table: $db.vehiculos,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$EgresosTableAnnotationComposer
    extends Composer<_$AppDatabase, $EgresosTable> {
  $$EgresosTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<double> get monto =>
      $composableBuilder(column: $table.monto, builder: (column) => column);

  GeneratedColumn<DateTime> get fecha =>
      $composableBuilder(column: $table.fecha, builder: (column) => column);

  GeneratedColumnWithTypeConverter<EgresoCategoria, int> get categoria =>
      $composableBuilder(column: $table.categoria, builder: (column) => column);

  GeneratedColumn<String> get descripcion => $composableBuilder(
    column: $table.descripcion,
    builder: (column) => column,
  );

  GeneratedColumn<String> get comprobantePath => $composableBuilder(
    column: $table.comprobantePath,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  $$ViajesTableAnnotationComposer get viajeId {
    final $$ViajesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.viajeId,
      referencedTable: $db.viajes,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ViajesTableAnnotationComposer(
            $db: $db,
            $table: $db.viajes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$VehiculosTableAnnotationComposer get vehiculoId {
    final $$VehiculosTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.vehiculoId,
      referencedTable: $db.vehiculos,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$VehiculosTableAnnotationComposer(
            $db: $db,
            $table: $db.vehiculos,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$EgresosTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $EgresosTable,
          Egreso,
          $$EgresosTableFilterComposer,
          $$EgresosTableOrderingComposer,
          $$EgresosTableAnnotationComposer,
          $$EgresosTableCreateCompanionBuilder,
          $$EgresosTableUpdateCompanionBuilder,
          (Egreso, $$EgresosTableReferences),
          Egreso,
          PrefetchHooks Function({bool viajeId, bool vehiculoId})
        > {
  $$EgresosTableTableManager(_$AppDatabase db, $EgresosTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$EgresosTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$EgresosTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$EgresosTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<double> monto = const Value.absent(),
                Value<DateTime> fecha = const Value.absent(),
                Value<EgresoCategoria> categoria = const Value.absent(),
                Value<String?> descripcion = const Value.absent(),
                Value<int?> viajeId = const Value.absent(),
                Value<int?> vehiculoId = const Value.absent(),
                Value<String?> comprobantePath = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => EgresosCompanion(
                id: id,
                monto: monto,
                fecha: fecha,
                categoria: categoria,
                descripcion: descripcion,
                viajeId: viajeId,
                vehiculoId: vehiculoId,
                comprobantePath: comprobantePath,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required double monto,
                required DateTime fecha,
                required EgresoCategoria categoria,
                Value<String?> descripcion = const Value.absent(),
                Value<int?> viajeId = const Value.absent(),
                Value<int?> vehiculoId = const Value.absent(),
                Value<String?> comprobantePath = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => EgresosCompanion.insert(
                id: id,
                monto: monto,
                fecha: fecha,
                categoria: categoria,
                descripcion: descripcion,
                viajeId: viajeId,
                vehiculoId: vehiculoId,
                comprobantePath: comprobantePath,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$EgresosTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({viajeId = false, vehiculoId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (viajeId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.viajeId,
                        referencedTable: $$EgresosTableReferences._viajeIdTable(
                          db,
                        ),
                        referencedColumn: $$EgresosTableReferences
                            ._viajeIdTable(db)
                            .id,
                      ) as T;
                    }
                    if (vehiculoId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.vehiculoId,
                        referencedTable: $$EgresosTableReferences
                            ._vehiculoIdTable(db),
                        referencedColumn: $$EgresosTableReferences
                            ._vehiculoIdTable(db)
                            .id,
                      ) as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$EgresosTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $EgresosTable,
      Egreso,
      $$EgresosTableFilterComposer,
      $$EgresosTableOrderingComposer,
      $$EgresosTableAnnotationComposer,
      $$EgresosTableCreateCompanionBuilder,
      $$EgresosTableUpdateCompanionBuilder,
      (Egreso, $$EgresosTableReferences),
      Egreso,
      PrefetchHooks Function({bool viajeId, bool vehiculoId})
    >;
typedef $$ImpuestosTableCreateCompanionBuilder = ImpuestosCompanion Function({
  Value<int> id,
  required String tipo,
  required String periodo,
  required double monto,
  required DateTime fechaVencimiento,
  Value<DateTime?> fechaPago,
  Value<ImpuestoEstado> estado,
  Value<String?> comprobantePath,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
});
typedef $$ImpuestosTableUpdateCompanionBuilder = ImpuestosCompanion Function({
  Value<int> id,
  Value<String> tipo,
  Value<String> periodo,
  Value<double> monto,
  Value<DateTime> fechaVencimiento,
  Value<DateTime?> fechaPago,
  Value<ImpuestoEstado> estado,
  Value<String?> comprobantePath,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
});

class $$ImpuestosTableFilterComposer
    extends Composer<_$AppDatabase, $ImpuestosTable> {
  $$ImpuestosTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get tipo => $composableBuilder(
    column: $table.tipo,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get periodo => $composableBuilder(
    column: $table.periodo,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get monto => $composableBuilder(
    column: $table.monto,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get fechaVencimiento => $composableBuilder(
    column: $table.fechaVencimiento,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get fechaPago => $composableBuilder(
    column: $table.fechaPago,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<ImpuestoEstado, ImpuestoEstado, int>
  get estado => $composableBuilder(
    column: $table.estado,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnFilters<String> get comprobantePath => $composableBuilder(
    column: $table.comprobantePath,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$ImpuestosTableOrderingComposer
    extends Composer<_$AppDatabase, $ImpuestosTable> {
  $$ImpuestosTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get tipo => $composableBuilder(
    column: $table.tipo,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get periodo => $composableBuilder(
    column: $table.periodo,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get monto => $composableBuilder(
    column: $table.monto,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get fechaVencimiento => $composableBuilder(
    column: $table.fechaVencimiento,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get fechaPago => $composableBuilder(
    column: $table.fechaPago,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get estado => $composableBuilder(
    column: $table.estado,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get comprobantePath => $composableBuilder(
    column: $table.comprobantePath,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ImpuestosTableAnnotationComposer
    extends Composer<_$AppDatabase, $ImpuestosTable> {
  $$ImpuestosTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get tipo =>
      $composableBuilder(column: $table.tipo, builder: (column) => column);

  GeneratedColumn<String> get periodo =>
      $composableBuilder(column: $table.periodo, builder: (column) => column);

  GeneratedColumn<double> get monto =>
      $composableBuilder(column: $table.monto, builder: (column) => column);

  GeneratedColumn<DateTime> get fechaVencimiento => $composableBuilder(
    column: $table.fechaVencimiento,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get fechaPago =>
      $composableBuilder(column: $table.fechaPago, builder: (column) => column);

  GeneratedColumnWithTypeConverter<ImpuestoEstado, int> get estado =>
      $composableBuilder(column: $table.estado, builder: (column) => column);

  GeneratedColumn<String> get comprobantePath => $composableBuilder(
    column: $table.comprobantePath,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$ImpuestosTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ImpuestosTable,
          Impuesto,
          $$ImpuestosTableFilterComposer,
          $$ImpuestosTableOrderingComposer,
          $$ImpuestosTableAnnotationComposer,
          $$ImpuestosTableCreateCompanionBuilder,
          $$ImpuestosTableUpdateCompanionBuilder,
          (Impuesto, BaseReferences<_$AppDatabase, $ImpuestosTable, Impuesto>),
          Impuesto,
          PrefetchHooks Function()
        > {
  $$ImpuestosTableTableManager(_$AppDatabase db, $ImpuestosTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ImpuestosTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ImpuestosTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ImpuestosTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> tipo = const Value.absent(),
                Value<String> periodo = const Value.absent(),
                Value<double> monto = const Value.absent(),
                Value<DateTime> fechaVencimiento = const Value.absent(),
                Value<DateTime?> fechaPago = const Value.absent(),
                Value<ImpuestoEstado> estado = const Value.absent(),
                Value<String?> comprobantePath = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => ImpuestosCompanion(
                id: id,
                tipo: tipo,
                periodo: periodo,
                monto: monto,
                fechaVencimiento: fechaVencimiento,
                fechaPago: fechaPago,
                estado: estado,
                comprobantePath: comprobantePath,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String tipo,
                required String periodo,
                required double monto,
                required DateTime fechaVencimiento,
                Value<DateTime?> fechaPago = const Value.absent(),
                Value<ImpuestoEstado> estado = const Value.absent(),
                Value<String?> comprobantePath = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => ImpuestosCompanion.insert(
                id: id,
                tipo: tipo,
                periodo: periodo,
                monto: monto,
                fechaVencimiento: fechaVencimiento,
                fechaPago: fechaPago,
                estado: estado,
                comprobantePath: comprobantePath,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$ImpuestosTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ImpuestosTable,
      Impuesto,
      $$ImpuestosTableFilterComposer,
      $$ImpuestosTableOrderingComposer,
      $$ImpuestosTableAnnotationComposer,
      $$ImpuestosTableCreateCompanionBuilder,
      $$ImpuestosTableUpdateCompanionBuilder,
      (Impuesto, BaseReferences<_$AppDatabase, $ImpuestosTable, Impuesto>),
      Impuesto,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$TrabajadoresTableTableManager get trabajadores =>
      $$TrabajadoresTableTableManager(_db, _db.trabajadores);
  $$VehiculosTableTableManager get vehiculos =>
      $$VehiculosTableTableManager(_db, _db.vehiculos);
  $$ViajesTableTableManager get viajes =>
      $$ViajesTableTableManager(_db, _db.viajes);
  $$IngresosTableTableManager get ingresos =>
      $$IngresosTableTableManager(_db, _db.ingresos);
  $$EgresosTableTableManager get egresos =>
      $$EgresosTableTableManager(_db, _db.egresos);
  $$ImpuestosTableTableManager get impuestos =>
      $$ImpuestosTableTableManager(_db, _db.impuestos);
}
