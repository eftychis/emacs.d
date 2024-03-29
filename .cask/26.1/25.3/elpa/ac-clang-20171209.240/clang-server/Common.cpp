/* -*- mode: c++ ; coding: utf-8-unix -*- */
/*  last updated : 2017/12/04.00:20:37 */

/*
 * Copyright (c) 2013-2017 yaruopooner [https://github.com/yaruopooner]
 *
 * This file is part of ac-clang.
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 * 
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 * 
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */


/*================================================================================================*/
/*  Comment                                                                                       */
/*================================================================================================*/


/*================================================================================================*/
/*  Include Files                                                                                 */
/*================================================================================================*/

#include <cstring>
#include <cstdarg>

#include "Common.hpp"




FlagConverter   ClangFlagConverters::sm_CXTranslationUnitFlags;
FlagConverter   ClangFlagConverters::sm_CXCodeCompleteFlags;



/*================================================================================================*/
/*  Global Class Method Definitions Section                                                       */
/*================================================================================================*/



Buffer::Buffer( size_t _Size, bool _IsFill, int _Value ) : 
    Buffer()
{
    Allocate( _Size, _IsFill, _Value );
}

Buffer::~Buffer( void )
{
    Deallocate();
}


void Buffer::Allocate( size_t _Size, bool _IsFill, int _Value )
{
    m_Size = _Size;

    if ( m_Size >= m_Capacity )
    {
        const size_t    extend_size   = std::max( Alignment< 16 >::Up( m_Size * 2 ), static_cast< size_t >( kInitialSize ) );
        uint8_t*        extend_buffer = reinterpret_cast< uint8_t* >( std::realloc( m_Address, extend_size ) );

        if ( extend_buffer )
        {
            m_Capacity = extend_size;
            m_Address  = extend_buffer;
        }
        else
        {
            // error
        }
    }

    if ( _IsFill )
    {
        Fill( _Value );
    }

}

void Buffer::Deallocate( void )
{
    if ( m_Address )
    {
        std::free( m_Address );
        m_Address = nullptr;
    }

    m_Size     = 0;
    m_Capacity = 0;
}


StreamReader::StreamReader( void )
{
    ClearLine();
}


void StreamReader::ClearLine( void )
{
    std::memset( m_Line, 0, kLineMax );
}


void StreamReader::StepNextLine( void )
{
    char    crlf[ kLineMax ];
    std::fgets( crlf, kLineMax, m_File );
}

const char* StreamReader::ReadToken( const char* _Format, bool _IsStepNextLine, bool _IsPolling )
{
    ClearLine();

    while ( ( std::fscanf( m_File, _Format, m_Line ) < 0 ) && _IsPolling )
    {
        // polling
        // const int   error_no = std::ferror( m_File );
        // const int   eof      = std::feof( m_File );
    }

    if ( _IsStepNextLine )
    {
        StepNextLine();
    }

    return ( m_Line );
}

void StreamReader::Read( char* _Buffer, size_t _ReadSize )
{
    const size_t    stored_size = std::fread( _Buffer, 1, _ReadSize, m_File );

    if ( (stored_size < _ReadSize) || std::feof( m_File ) )
    {
        // error
    }
}


void StreamWriter::Write( const char* _Format, ... )
{
    va_list    args;
    va_start( args, _Format );
    
    std::vfprintf( m_File, _Format, args );

    va_end( args );
}

void StreamWriter::Flush( void )
{
    std::fprintf( m_File, "$" );
    std::fflush( m_File );
}


PacketManager::PacketManager( void )
{
}

void PacketManager::Receive( void )
{
    int32_t     packet_size = 0;

    m_Reader.ReadToken( "PacketSize:%d", packet_size );

    // realloc & fill by 0
    // for termination character (\0)
    m_ReceiveBuffer.Allocate( packet_size + 1, true );

    // read from stdin
    // NOTICE: don't use m_ReceiveBuffer.GetSize()
    // Because, the buffer size is increasing due to the termination character.
    m_Reader.Read( m_ReceiveBuffer.GetAddress< char* >(), packet_size );

    m_ReceivedSize = packet_size;
}

void PacketManager::Send( void )
{
    m_Writer.Write( "%s", m_SendBuffer.GetAddress< char* >() );
    m_Writer.Flush();
}


CFlagsBuffer::~CFlagsBuffer( void )
{
    Deallocate();
}


void CFlagsBuffer::Allocate( const std::vector< std::string >& _CFlags )
{
    Deallocate();

    m_NumberOfCFlags = static_cast< int32_t >( _CFlags.size() );
    m_CFlags         = reinterpret_cast< char** >( std::calloc( sizeof( char* ), m_NumberOfCFlags ) );

    for ( int32_t i = 0; i < m_NumberOfCFlags; ++i )
    {
        m_CFlags[ i ] = reinterpret_cast< char* >( std::calloc( sizeof( char ), _CFlags[ i ].length() + 1 ) );

        std::strcpy( m_CFlags[ i ], _CFlags[ i ].c_str() );
    }
}

void CFlagsBuffer::Deallocate( void )
{
    if ( !m_CFlags )
    {
        return;
    }

    for ( int32_t i = 0; i < m_NumberOfCFlags; ++i )
    {
        std::free( m_CFlags[ i ] );
    }
    std::free( m_CFlags );

    m_CFlags         = nullptr;
    m_NumberOfCFlags = 0;
}


CSourceCodeBuffer::~CSourceCodeBuffer( void )
{
    Deallocate();
}


void CSourceCodeBuffer::Allocate( int32_t _Size )
{
    m_Size = _Size;

    if ( m_Size >= m_BufferCapacity )
    {
        const int32_t   extend_size   = std::max( m_Size * 2, static_cast< int32_t >( kInitialSrcBufferSize ) );
        char*           extend_buffer = reinterpret_cast< char* >( std::realloc( m_Buffer, extend_size ) );

        if ( extend_buffer )
        {
            m_BufferCapacity = extend_size;
            m_Buffer         = extend_buffer;
        }
        else
        {
            // error
        }
    }
}

void CSourceCodeBuffer::Deallocate( void )
{
    if ( m_Buffer )
    {
        std::free( m_Buffer );
        m_Buffer = nullptr;
    }

    m_Size = 0;
}



ClangContext::ClangContext( bool _IsExcludeDeclarationsFromPCH ) : 
    m_CxIndex( nullptr )
    , m_ExcludeDeclarationsFromPCH( _IsExcludeDeclarationsFromPCH )
    , m_TranslationUnitFlags( CXTranslationUnit_PrecompiledPreamble )
    , m_CompleteAtFlags( CXCodeComplete_IncludeMacros )
    , m_CompleteResultsLimit( 0 )
{
    Allocate();
}

ClangContext::~ClangContext( void )
{
    Deallocate();
}


void ClangContext::Allocate( void )
{
    m_CxIndex = clang_createIndex( m_ExcludeDeclarationsFromPCH, 0 );
}

void ClangContext::Deallocate( void )
{
    if ( m_CxIndex )
    {
        clang_disposeIndex( m_CxIndex );
        m_CxIndex = nullptr;
    }
}




ClangFlagConverters::ClangFlagConverters( void )
{
    sm_CXTranslationUnitFlags.Add( FLAG_DETAILS( CXTranslationUnit_DetailedPreprocessingRecord ) );
    sm_CXTranslationUnitFlags.Add( FLAG_DETAILS( CXTranslationUnit_Incomplete ) );
    sm_CXTranslationUnitFlags.Add( FLAG_DETAILS( CXTranslationUnit_PrecompiledPreamble ) );
    sm_CXTranslationUnitFlags.Add( FLAG_DETAILS( CXTranslationUnit_CacheCompletionResults ) );
    sm_CXTranslationUnitFlags.Add( FLAG_DETAILS( CXTranslationUnit_ForSerialization ) );
    sm_CXTranslationUnitFlags.Add( FLAG_DETAILS( CXTranslationUnit_CXXChainedPCH ) );
    sm_CXTranslationUnitFlags.Add( FLAG_DETAILS( CXTranslationUnit_SkipFunctionBodies ) );
    sm_CXTranslationUnitFlags.Add( FLAG_DETAILS( CXTranslationUnit_IncludeBriefCommentsInCodeCompletion ) );
    sm_CXTranslationUnitFlags.Add( FLAG_DETAILS( CXTranslationUnit_CreatePreambleOnFirstParse ) );
    sm_CXTranslationUnitFlags.Add( FLAG_DETAILS( CXTranslationUnit_KeepGoing ) );
    sm_CXTranslationUnitFlags.Add( FLAG_DETAILS( CXTranslationUnit_SingleFileParse ) );

    sm_CXCodeCompleteFlags.Add( FLAG_DETAILS( CXCodeComplete_IncludeMacros ) );
    sm_CXCodeCompleteFlags.Add( FLAG_DETAILS( CXCodeComplete_IncludeCodePatterns ) );
    sm_CXCodeCompleteFlags.Add( FLAG_DETAILS( CXCodeComplete_IncludeBriefComments ) );
}




/*================================================================================================*/
/*  EOF                                                                                           */
/*================================================================================================*/
